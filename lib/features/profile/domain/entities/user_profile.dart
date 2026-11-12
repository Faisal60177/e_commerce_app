import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

@freezed
abstract class UserProfile  with _$UserProfile{
  const factory UserProfile({
    @Default('') String phone,
    @Default(0) int avatarIndex,
}) = _UserProfile;
}