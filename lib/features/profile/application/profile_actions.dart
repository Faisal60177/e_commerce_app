import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/profile/application/profile_providers.dart';
import 'package:e_commerce_app/features/profile/domain/entities/user_profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_actions.g.dart';

@Riverpod(keepAlive: true)
ProfileActions profileActions(Ref ref) => ProfileActions(ref);

class ProfileActions {
  ProfileActions(this._ref);
  final Ref _ref;

  String get _uid {
    final uid = _ref.read(currentUidProvider);
    if(uid == null) throw const AuthFailure('Please sign in first');
    return uid;
  }

  Future<void> save({
    required String name,
    required String phone,
    required int avatarIndex,
}) async {
    final uid = _uid;
    final auth = _ref.read(authRepositoryProvider);
    final current = _ref.read(authUserProvider).value;

    if(current?.displayName?.trim() != name.trim()) {
      await auth.updateDisplayName(name);
    }
    await _ref.read(profileRepositoryProvider).saveProfile(
      uid, UserProfile(phone: phone.trim(), avatarIndex: avatarIndex),
    );
    _ref.invalidate(authUserProvider);
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
}) {
    return _ref.read(authRepositoryProvider).changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  Future<void> deleteAccount({String? password}) async {
    final uid = _uid;
    final auth = _ref.read(authRepositoryProvider);

    await auth.reauthenticate(password: password);
    await _ref.read(profileRepositoryProvider).deleteUserData(uid);
    await auth.deleteAccount();
  }
}