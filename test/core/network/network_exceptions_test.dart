import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/network/network_exceptions.dart';
import 'package:flutter_test/flutter_test.dart';

final _options = RequestOptions(path: '/products');

DioException _error(
  DioExceptionType type, {
  Response<dynamic>? response,
  Object? error,
}) {
  return DioException(
    requestOptions: _options,
    type: type,
    response: response,
    error: error,
  );
}

void main() {
  group('DioException.toFailure', () {
    test('timeouts become TimeoutFailure', () {
      expect(
        _error(DioExceptionType.connectionTimeout).toFailure(),
        isA<TimeoutFailure>(),
      );
      expect(
        _error(DioExceptionType.receiveTimeout).toFailure(),
        isA<TimeoutFailure>(),
      );
    });

    test('connection errors become NetworkFailure', () {
      expect(
        _error(DioExceptionType.connectionError).toFailure(),
        isA<NetworkFailure>(),
      );
      expect(
        _error(
          DioExceptionType.unknown,
          error: const SocketException('offline'),
        ).toFailure(),
        isA<NetworkFailure>(),
      );
    });

    test('404 becomes NotFoundFailure', () {
      final failure = _error(
        DioExceptionType.badResponse,
        response: Response<dynamic>(requestOptions: _options, statusCode: 404),
      ).toFailure();

      expect(failure, isA<NotFoundFailure>());
    });

    test('server errors keep the API message and status code', () {
      final failure = _error(
        DioExceptionType.badResponse,
        response: Response<dynamic>(
          requestOptions: _options,
          statusCode: 500,
          data: {'message': 'Boom'},
        ),
      ).toFailure();

      expect(failure, isA<ServerFailure>());
      expect(failure.message, 'Boom');
      expect((failure as ServerFailure).statusCode, 500);
    });
  });

  group('guardApi', () {
    test('maps DioException to a Failure', () {
      expect(
        guardApi<int>(
          () async => throw _error(DioExceptionType.connectionError),
        ),
        throwsA(isA<NetworkFailure>()),
      );
    });

    test('lets a Failure through unchanged', () {
      expect(
        guardApi<int>(() async => throw const NotFoundFailure()),
        throwsA(isA<NotFoundFailure>()),
      );
    });

    test('maps a TypeError to UnknownFailure', () {
      Future<int> parse() async {
        final Object value = 'not a number';
        return value as int;
      }

      expect(guardApi(parse), throwsA(isA<UnknownFailure>()));
    });

    test('returns the value on success', () async {
      expect(await guardApi(() async => 42), 42);
    });
  });
}
