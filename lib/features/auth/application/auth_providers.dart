import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/features/auth/data/firebase_auth_repository.dart';
import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/google_sign_in_service.dart';

part 'auth_providers.g.dart';

enum AuthStatus { unknown, signedOut, needsVerification, signedIn }

@Riverpod(keepAlive: true)
AuthStatus authStatus(Ref ref) {
  final auth = ref.watch(authUserProvider);
  if (!auth.hasValue) {
    return auth.hasError ? AuthStatus.signedOut : AuthStatus.unknown;
  }
  final user = auth.value;
  if (user == null) return AuthStatus.signedOut;
  return user.needsVerification
      ? AuthStatus.needsVerification
      : AuthStatus.signedIn;
}

const _googleServerClientId = String.fromEnvironment(
  'GOOGLE_SERVER_CLIENT_ID',
  defaultValue: '734844384596-akn8fdeug1q0hgsabcsbe0larm37anen.apps.googleusercontent.com',
);

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return FirebaseAuthRepository(
    ref.watch(firebaseAuthProvider),
    ref.watch(googleSignInServiceProvider),
  );
}
@Riverpod(keepAlive: true)
GoogleSignInService googleSignInService(Ref ref) {
  return GoogleSignInService(
    GoogleSignIn.instance,
    serverClientId: _googleServerClientId,
  );
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authUser(Ref ref) {
  return ref.watch(authRepositoryProvider).userStream;
}

@Riverpod(keepAlive: true)
String? currentUid(Ref ref) {
  return ref.watch(authUserProvider.select((state) => state.value?.uid));
}
