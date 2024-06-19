import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todoist/core/services/network/api_path.dart';
import 'package:todoist/core/services/network/dio_error_handler.dart';
import 'package:todoist/core/services/network/dio_wrapper.dart';
import 'package:todoist/utils/dependency_injection/initial_controller.dart';

class InitialBindings {
  Future<void> onInit() async {
    await _initDependencies();
    await _initDataSources();
    await _initAppUseCases();
  }

  Future<void> _initAppUseCases() async {}

  Future<void> _initDataSources() async {}

  Future<void> _initDependencies() async {
    Get.put<Dio>(
      Dio(
        BaseOptions(
          receiveTimeout: const Duration(milliseconds: 6000),
          connectTimeout: const Duration(milliseconds: 6000),
          sendTimeout: const Duration(milliseconds: 6000),
          baseUrl: APIPaths.baseUrl,
        ),
      ),
      permanent: true,
    );

    Get.put<DioErrorHandler>(DioErrorHandlerImpl(), permanent: true);

    Get.put<IDioWrapper>(
      DioWrapperImpl(
        dio: Get.find<Dio>(),
        dioErrorHandler: Get.find(),
      ),
      permanent: true,
    );

    _addDioInterceptors();

    Get.put<InitialController>(
      InitialController(),
      permanent: true,
    );
  }

  void _addDioInterceptors() {
    Dio dio = Get.find<Dio>();

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (value) {
          if (kDebugMode) {
            log('LogInterceptor => $value');
          }
        },
      ),
    );

    Map<String, String> apiHeaders = {
      'Accept': 'application/json',
      'Content-type': 'application/json',
    };
    dio.options.headers.addAll(apiHeaders);
  }
}
