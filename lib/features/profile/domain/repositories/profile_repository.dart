import 'package:e_commerce_app/features/profile/domain/entities/user_profile.dart';

abstract interface class ProfileRepository {
  Stream<UserProfile> watchProfile(String uid);

  Future<void> saveProfile(String uid, UserProfile profile);

  Future<void> deleteUserData(String uid);
}