import 'dart:developer' as developer;

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  GoogleSignInService(this._google, {required this.serverClientId});

  final GoogleSignIn _google;
  final String serverClientId;
  Future<void>? _init;

  Future<void> _ensureInit() => _init ??= _google
      .initialize(serverClientId: serverClientId)
      .catchError((Object e) {
        _init = null;
        throw e;
      });

  Future<AuthCredential?> getCredential() async {
    await _ensureInit();
    if (!_google.supportsAuthenticate()) {
      throw const AuthFailure(
        'Google sign-in is not supported on this device.',
      );
    }
    try {
      final account = await _google.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        developer.log('Google idToken is null', name: 'auth');
        throw const AuthFailure('Google sign-in failed. Please try again.');
      }
      return GoogleAuthProvider.credential(idToken: idToken);
    } on GoogleSignInException catch (e) {
      switch (e.code) {
        case GoogleSignInExceptionCode.canceled:
          return null;
        case GoogleSignInExceptionCode.interrupted:
          throw const AuthFailure('Sign-in was interrupted. Please try again.');
        default:
          developer.log(
            'Google sign-in error: ${e.code}',
            name: 'auth',
            error: e,
          );
          throw const AuthFailure('Google sign-in failed. Please try again.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _ensureInit();
      await _google.signOut();
    } catch (e, st) {
      developer.log(
        'Google signOut failed',
        name: 'auth',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> disconnect() async {
    try {
      await _ensureInit();
      await _google.disconnect();
    } catch (e, st) {
      developer.log(
        'Google disconnect failed',
        name: 'auth',
        error: e,
        stackTrace: st,
      );
    }
  }
}
