import 'package:dio/dio.dart';

class RetryInterceptor  extends Interceptor{
  RetryInterceptor({required this.dio, this.maxRetries = 2});

  final Dio dio;
  final int maxRetries;

  static const _attemptKey = 'retry_attempt';

  static const _retryableTypes = {
    DioExceptionType.connectionTimeout,
    DioExceptionType.receiveTimeout,
    DioExceptionType.connectionError
  };

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    final options = err.requestOptions;
    final attempt = (options.extra[_attemptKey] as int?) ?? 0;

    final canRetry = options.method == 'GET' &&
    attempt < maxRetries &&
    _retryableTypes.contains(err.type);

    if(!canRetry) return handler.next(err);

    options.extra[_attemptKey] = attempt + 1;

    await Future<void>.delayed(Duration(milliseconds: 500 * (attempt + 1)));
     try{
       final response = await dio.fetch<dynamic> (options);
       handler.resolve(response);
     } on DioException catch(e) {
       handler.next(e);
     }

  }


}