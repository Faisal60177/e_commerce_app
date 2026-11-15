import 'dart:developer' as developer;

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseAuthExceptionX on FirebaseAuthException {
  AuthFailure toAuthFailure() {
    final (text, failureCode) = switch (code) {
      'invalid-email' => (
      'That email address looks invalid.',
      AuthFailureCode.invalidEmail,
      ),
      'user-disabled' => (
      'This account has been disabled.',
      AuthFailureCode.accountDisabled,
      ),
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' ||
      'invalid-login-credentials' => (
      'Incorrect email or password.',
      AuthFailureCode.invalidCredentials,
      ),
      'email-already-in-use' => (
      'An account already exists for that email. '
          'Try signing in, or use "Continue with Google".',
      AuthFailureCode.emailInUse,
      ),
      'weak-password' || 'password-does-not-meet-requirements' => (
      'Please choose a stronger password.',
      AuthFailureCode.weakPassword,
      ),
      'too-many-requests' || 'quota-exceeded' => (
      'Too many attempts. Please wait a moment and try again.',
      AuthFailureCode.tooManyRequests,
      ),
      'network-request-failed' => (
      'No internet connection. Please check your network.',
      AuthFailureCode.network,
      ),
      'operation-not-allowed' => (
      'This sign-in method is not enabled.',
      AuthFailureCode.unknown,
      ),
      'account-exists-with-different-credential' ||
      'credential-already-in-use' => (
      'This email is registered with a different sign-in method.',
      AuthFailureCode.differentProvider,
      ),
      'requires-recent-login' || 'user-token-expired' => (
      'For your security, please sign in again and retry.',
      AuthFailureCode.requiresRecentLogin,
      ),
      _ => (
      'Authentication failed. Please try again.',
      AuthFailureCode.unknown,
      ),
    };

    if (failureCode == AuthFailureCode.unknown) {
      developer.log('Unmapped auth error: $code', name: 'auth', error: this);
    }
    return AuthFailure(text, code: failureCode);
  }
}