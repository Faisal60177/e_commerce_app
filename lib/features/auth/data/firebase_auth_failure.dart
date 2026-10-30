import 'package:e_commerce_app/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseAuthExceptionX  on FirebaseAuthException {
  AuthFailure toAuthFailure() {
    final text = switch(code) {
      'invalid-email' => 'That email address looks invalid.',
      'user-disabled' => 'This account has been disabled.',
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' ||
      'invalid-login-credentials' =>
      'Incorrect email or password.',
      'email-already-in-use' => 'An account already exists for that email.',
      'weak-password' => 'Please choose a stronger password.',
      'too-many-requests' =>
      'Too many attempts. Please wait a moment and try again.',
      'network-request-failed' =>
      'No internet connection. Please check your network.',
      'operation-not-allowed' => 'This sign-in method is not enabled.',
      'account-exists-with-different-credential' =>
      'This email is registered with a different sign-in method.',
      _ => message ?? 'Authentication failed. Please try again.',
    };
    return AuthFailure(text);
  }

}