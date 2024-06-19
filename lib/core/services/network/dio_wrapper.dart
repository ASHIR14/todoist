import 'package:dio/dio.dart';
import 'package:get/get.dart' as g;
import 'package:logger/logger.dart';
import 'package:todoist/core/model/failures.dart';
import 'package:todoist/core/services/network/dio_error_handler.dart';
import 'package:todoist/utils/network/network_info.dart';

import 'dio_interceptor_wrapper.dart';

abstract class IDioWrapper {
  Future<Response<dynamic>> onPost(
      {required String api,
      required dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      String? jwt});

  Future<Response<dynamic>> onPatch(
      {required String api,
      required dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      String? jwt});

  Future<Response<dynamic>> onGet({
    required String api,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? jwt,
    bool useCache = false,
  });

  Future<Response<dynamic>> onPut(
      {required String api,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});

  Future<Response<dynamic>> onDelete(
      {required String api,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      String? jwt});

  void resolveAPIMetadata(
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      String? jwt});

  Future<Response<dynamic>> downloadToPath(
      {required String url,
      required String savePath,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});
}

class DioWrapperImpl extends IDioWrapper {
  final Dio _dio;
  final DioErrorHandler _dioErrorHandler;
  final Logger _logger = Logger();

  DioWrapperImpl({
    required Dio dio,
    required DioErrorHandler dioErrorHandler,
  })  : _dio = dio,
        _dioErrorHandler = dioErrorHandler;

  @override
  Future<Response<dynamic>> onPost({
    required String api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? jwt,
  }) async {
    if (!await NetworkInfo.isConnected) {
      throw const NetworkFailure(message: 'No Internet connection');
    }

    try {
      resolveAPIMetadata(
          queryParameters: queryParameters, headers: headers, jwt: jwt);
      return await _dio.post(api, data: data);
    } on DioException catch (e) {
      _logger.f('[ON POST | DIO ERROR | API $api] ${e.response}');
      if (e.type == DioExceptionType.badResponse) {
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      _logger.f('[ON POST | SOMETHING WENT WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  Future<Response<dynamic>> onPatch({
    required String api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? jwt,
  }) async {
    if (!await NetworkInfo.isConnected) {
      throw const NetworkFailure(message: 'No Internet connection');
    }
    try {
      resolveAPIMetadata(
          queryParameters: queryParameters, headers: headers, jwt: jwt);
      return await _dio.patch(api, data: data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        _logger.f('[ON PATCH | DIO ERROR | API $api] ${e.response}');
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      _logger.f('[ON PATCH | SOMETHING WENT WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  Future<Response<dynamic>> onGet({
    required String api,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic data,
    String? jwt,
    bool useCache = false,
  }) async {
    if (!useCache && !await NetworkInfo.isConnected) {
      throw const NetworkFailure(message: 'No Internet connection');
    }
    try {
      _dio.options.headers.remove('Authorization');
      resolveAPIMetadata(
          queryParameters: queryParameters, headers: headers, jwt: jwt);
      return await _dio.get(
        api,
        data: data,
      );
    } on DioException catch (e) {
      _logger.f('[ON GET | DIO ERROR | API $api] $e');
      if (e.type == DioExceptionType.badResponse) {
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      _logger.f('[ON GET | SOMETHING WENT WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  Future<Response<dynamic>> onPut({
    required String api,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    if (!await NetworkInfo.isConnected) {
      throw const NetworkFailure(message: 'No Internet connection');
    }

    try {
      _dio.options.headers.remove('Authorization');
      resolveAPIMetadata(queryParameters: queryParameters, headers: headers);
      return await _dio.put(api, data: data);
    } on DioException catch (e) {
      _logger.f('[ON GET | DIO ERROR | API $api] $e');
      if (e.type == DioExceptionType.badResponse) {
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      _logger.f('[ON GET | SOMETHING WENT WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  Future<Response<dynamic>> onDelete({
    required String api,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? jwt,
  }) async {
    if (!await NetworkInfo.isConnected) {
      throw const NetworkFailure(message: 'No Internet connection');
    }

    try {
      resolveAPIMetadata(queryParameters: queryParameters, headers: headers, jwt: jwt);
      return await _dio.delete(api);
    } on DioException catch (e) {
      _logger.f('[ON DELETE | DIO ERROR | API $api] $e');
      if (e.type == DioExceptionType.badResponse) {
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      _logger.f('[ON DELETE | SOMETHING WENT WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  void resolveAPIMetadata(
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      String? jwt}) {
    _dio.options.queryParameters.clear();
    if (queryParameters != null) {
      _dio.options.queryParameters.addAll(queryParameters);
    }
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    _dio.interceptors.addAll([DioCustomInterceptors()]);
  }

  @override
  Future<Response> downloadToPath(
      {required String url,
      required String savePath,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    if (!await NetworkInfo.isConnected) {
      throw const NetworkFailure(message: "No Internet connection");
    }
    try {
      resolveAPIMetadata(queryParameters: queryParameters, headers: headers);
      return await _dio.download(url, savePath,
          queryParameters: queryParameters);
    } on DioException catch (e) {
      _logger.e('[ON GET | DIO ERROR | API $url] $e');
      if (e.response != null) {
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      _logger.e('[ON GET | SOMETHING WENT WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }
}
