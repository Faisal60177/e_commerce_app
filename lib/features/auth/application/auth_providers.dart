import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/features/auth/data/firebase_auth_repository.dart';
import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return FirebaseAuthRepository(ref.watch(firebaseAuthProvider));
}

@Riverpod(keepAlive : true)
Stream<AppUser?> authUser(Ref ref) {
  return ref.watch(authRepositoryProvider).userStream;
}

@Riverpod(keepAlive: true)
String? currentUid(Ref ref) {
  return ref.watch(authUserProvider.select((state) => state.value?.uid));
}