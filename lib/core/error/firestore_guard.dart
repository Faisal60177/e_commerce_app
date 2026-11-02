import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/error/failure.dart';

Failure mapFirestoreError (FirebaseException error) {
  return switch(error.code) {
    'permission-denied' =>
  const DatabaseFailure('You do not have permission to do that.'),
  'unavailable' || 'deadline-exceeded' => const NetworkFailure(),
  'not-found' => const NotFoundFailure(),
  _ => DatabaseFailure(error.message ?? 'Database error. Please try again.'),
  };
}

Future<T> guardFirestore<T> (Future<T> Function() action) async {
  try {
    return await action();
  } on FirebaseException catch (e) {
    throw mapFirestoreError(e);
  }
}