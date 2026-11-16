import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/data/firebase_auth_failure.dart';
import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:developer' as developer;

import 'google_sign_in_service.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth, this._google);

  final FirebaseAuth _auth;
  final GoogleSignInService _google;

  @override
  Stream<AppUser?> get userStream => _auth.userChanges().map(_toAppUser);

  @override
  AppUser? get currentUser => _toAppUser(_auth.currentUser);

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = credential.user!;
      await _bestEffort(
        () => user.updateDisplayName(name.trim()),
        'updateDisplayName',
      );
      await _bestEffort(user.sendEmailVerification, 'sendEmailVerification');
      await _bestEffort(user.reload, 'reload');
    });
  }

  @override
  Future<void> signIn({required String email, required String password}) {
    return _guard(() async {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    });
  }

  @override
  Future<bool> signInWithGoogle() async {
    final credential = await _google.getCredential();
    if (credential == null) return false;
    await _guard(() => _auth.signInWithCredential(credential));
    return true;
  }

  @override
  Future<void> sendVerificationEmail() {
    return _guard(() => _requireUser().sendEmailVerification());
  }

  @override
  Future<AppUser?> reloadUser() {
    return _guard(() async {
      final user = _auth.currentUser;
      if (user != null) {
        final wasVerified = user.emailVerified;
        await user.reload();
        final fresh = _auth.currentUser;
        if (!wasVerified && (fresh?.emailVerified ?? false)) {
          await fresh!.getIdToken(true);
        }
      }
      return currentUser;
    });
  }

  @override
  Future<void> sendPasswordReset(String email) {
    return _guard(() => _auth.sendPasswordResetEmail(email: email.trim()));
  }

  @override
  Future<void> updateDisplayName(String name) {
    return _guard(() async {
      final user = _requireUser();
      await user.updateDisplayName(name.trim());
      await user.reload();
    });
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _guard(() async {
      await _reauthWithPassword(currentPassword);
      await _requireUser().updatePassword(newPassword);
    });
  }

  @override
  Future<void> reauthenticate({String? password}) async {
    final user = _requireUser();
    final usesPassword = user.providerData.any(
      (p) => p.providerId == 'password',
    );

    if (usesPassword) {
      if (password == null || password.isEmpty) {
        throw const AuthFailure('Please enter your password.');
      }
      return _guard(() => _reauthWithPassword(password));
    }

    final credential = await _guard(_google.getCredential);
    if (credential == null) {
      throw const AuthFailure(
        'Verification was cancelled.',
        code: AuthFailureCode.cancelled,
      );
    }
    await _guard(() => user.reauthenticateWithCredential(credential));
  }

  @override
  Future<void> deleteAccount() async {
    await _guard(() => _requireUser().delete());
    await _google.disconnect();
  }

  @override
  Future<void> signOut() async {
    await _google.signOut();
    await _guard(_auth.signOut);
  }

  User _requireUser() {
    return _auth.currentUser ??
        (throw const AuthFailure('You are signed out.'));
  }

  Future<void> _reauthWithPassword(String password) async {
    final user = _requireUser();
    final email = user.email;
    if (email == null) {
      throw const AuthFailure('This account has no email address.');
    }
    await user.reauthenticateWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
  }

  AppUser? _toAppUser(User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      emailVerified: user.emailVerified,
      hasPassword: user.providerData.any((p) => p.providerId == 'password'),
      hasGoogle: user.providerData.any((p) => p.providerId == 'google.com'),
    );
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on Failure {
      rethrow;
    } on FirebaseAuthException catch (e) {
      throw e.toAuthFailure();
    } on FirebaseException catch (e, st) {
      developer.log(
        'Firebase error: ${e.code}',
        name: 'auth',
        error: e,
        stackTrace: st,
      );
      throw const AuthFailure('Authentication failed. Please try again.');
    } catch (e, st) {
      developer.log(
        'Unexpected auth error',
        name: 'auth',
        error: e,
        stackTrace: st,
      );
      throw const UnknownFailure();
    }
  }

  Future<void> _bestEffort(Future<void> Function() action, String label) async {
    try {
      await action();
    } catch (e, st) {
      developer.log('$label failed', name: 'auth', error: e, stackTrace: st);
    }
  }
}
