import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/error/failure.dart';

extension DioExceptionX on DioException {
  Failure toFailure() {
    return switch (type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout =>
      const TimeoutFailure(),
      DioExceptionType.connectionError => const NetworkFailure(),
      DioExceptionType.badResponse => _fromResponse(),
      DioExceptionType.cancel => const UnknownFailure('Request was cancelled.'),
      DioExceptionType.badCertificate =>
      const ServerFailure(message: 'Secure connection failed.'),
      DioExceptionType.unknown =>
      error is SocketException ? const NetworkFailure() : const UnknownFailure(),
    };
  }

  Failure _fromResponse() {
    final status = response?.statusCode;
    if (status == 404) return const NotFoundFailure();

    final data = response?.data;
    final message = data is Map<String, dynamic> ? data['message'] : null;
    return ServerFailure(
      message: message is String ? message : 'Server error ($status).',
      statusCode: status,
    );
  }
}

Future<T> guardApi<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (e) {
    throw e.toFailure();
  } on Failure {
    rethrow;
  } on Exception {
    throw const UnknownFailure('Unexpected response from the server.');
  }
}
