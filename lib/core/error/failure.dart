sealed class Failure  implements Exception{
  const Failure(this.message);

  final String message;

  @override
  String toString() => message;
}

final class NetworkFailure extends Failure {
  const NetworkFailure([super.message =
  'No internet connection. Please check your network.',
  ]);
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure([
    super.message =
    'The request timed out. Please try again.',

  ]);
}

final class ServerFailure extends Failure {
  const ServerFailure({
    String message = 'Something went wrong on the server.',
    this.statusCode,
  }) : super(message);

  final int? statusCode;
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure([
    super.message = 'The requested resource was not found.',
  ]);
}

final class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

final class DatabaseFailure extends Failure{
  const DatabaseFailure([
    super.message = 'Could not complete the database operation.',
  ]);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([
    super.message = 'Something went wrong. Please try again.',
  ]);
}

String failureMessage(Object error) =>
    error is Failure ? error.message : 'Something went wrong. Please try again.';