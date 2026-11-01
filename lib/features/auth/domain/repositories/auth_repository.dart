import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';

abstract interface class AuthRepository {
  Stream<AppUser?> get userStream;
  AppUser? get currentUser;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
});

  Future<void> signIn({
    required String email, required String password
});
  Future<bool> signInWithGoogle();
  Future<void> sendVerificationEmail();
  Future<AppUser?> reloadUser();
  Future<void> sendPasswordReset(String email);
  Future <void> signOut();
}