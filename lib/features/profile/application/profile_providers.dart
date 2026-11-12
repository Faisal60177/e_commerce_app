import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/profile/data/firestore_profile_repository.dart';
import 'package:e_commerce_app/features/profile/domain/entities/user_profile.dart';
import 'package:e_commerce_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_providers.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) {
  return FirestoreProfileRepository(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
Stream<UserProfile> userProfile(Ref ref) {
  final uid = ref.watch(currentUidProvider);
  if(uid == null) return Stream.value(const UserProfile());
  return ref.watch(profileRepositoryProvider).watchProfile(uid);
}