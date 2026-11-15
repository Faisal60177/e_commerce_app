import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<bool> signIn({required String email, required String password}) =>
      _run(() => _repo.signIn(email: email, password: password));

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) => _run(() => _repo.signUp(name: name, email: email, password: password));

  Future<bool> signInWithGoogle() async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(_repo.signInWithGoogle);
    if (!ref.mounted) return false;
    state = result;
    return result.value ?? false;
  }

  Future<bool> sendVerificationEmail() => _run(_repo.sendVerificationEmail);

  Future<bool> sendPasswordReset(String email) =>
      _run(() => _repo.sendPasswordReset(email));

  Future<void> signOut() async {
    await _run(_repo.signOut);
  }

  Future<bool> refreshUser({bool silent = false}) async {
    if (!silent) state = const AsyncLoading();
    try {
      final user = await _repo.reloadUser();
      if (!ref.mounted) return false;
      if (!silent) state = const AsyncData(null);
      return user?.emailVerified ?? false;
    } on Failure catch (failure, st) {
      if (ref.mounted && !silent) state = AsyncError(failure, st);
      return false;
    }
  }

  Future<bool> _run(Future<void> Function() action) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(action);
    if (ref.mounted) state = result;
    return !result.hasError;
  }
}
