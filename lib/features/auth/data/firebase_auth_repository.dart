import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/data/firebase_auth_failure.dart';
import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  static const _cancelCodes = {
    'canceled',
    'cancelled',
    'web-context-canceled',
    'popup-closed-by-user',
    'cancelled-popup-request',
  };

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
        email: email,
        password: password,
      );
      final user = credential.user!;
      await user.updateDisplayName(name.trim());
      await user.sendEmailVerification();
      await user.reload();
    });
  }

  @override
  Future<void> signIn({required String email, required String password}) {
    return _guard(() async {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    });
  }

  @override
  Future<bool> signInWithGoogle() async {
    try {
      await _auth.signInWithProvider(GoogleAuthProvider());
      return true;
    } on FirebaseAuthException catch (e) {
      if (_cancelCodes.contains(e.code)) return false;
      throw e.toAuthFailure();
    }
  }

  @override
  Future<void> sendVerificationEmail() {
    return _guard(() async {
      final user = _auth.currentUser;
      if (user == null) throw const AuthFailure('You are signed out.');
      await user.sendEmailVerification();
    });
  }

  @override
  Future<AppUser?> reloadUser() {
    return _guard(() async {
      await _auth.currentUser?.reload();
      return currentUser;
    });
  }

  @override
  Future<void> sendPasswordReset(String email) {
    return _guard(() => _auth.sendPasswordResetEmail(email: email));
  }

  @override
  Future<void> signOut() => _guard(_auth.signOut);

  AppUser? _toAppUser(User? user) {
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      emailVerified: user.emailVerified,
    );
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      throw e.toAuthFailure();
    } on FirebaseException catch (e) {
      throw AuthFailure(e.message ?? 'Authentication failed.');
    }
  }
}