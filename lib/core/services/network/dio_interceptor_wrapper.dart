import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioCustomInterceptors extends Interceptor {
  DioCustomInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] =
        'Bearer dd087fc55736d6f9b867ac8594c883ab547d8071';
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }
}
