import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    @Default('') String email,
    String? displayName,
    String? photoUrl,
    @Default(false) bool emailVerified,
  }) = _AppUser;

  const AppUser._();

  String get displayLabel {
    final name = displayName?.trim();
    if (name != null && name.isNotEmpty) return name;
    final prefix = email.split('@').first;
    return prefix.isEmpty ? 'Shopper' : prefix;
  }

  String get initial => displayLabel[0].toUpperCase();
}