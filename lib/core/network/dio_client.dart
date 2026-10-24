import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/network/interceptors/retry_interceptor.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_constants.dart';

Dio createDio() {

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      responseType: ResponseType.json,
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.addAll([
    if(kDebugMode) LogInterceptor(),
    RetryInterceptor(dio: dio),
  ]);

  return dio;

}