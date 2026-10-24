import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_controller.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ref.read(appPreferencesProvider).themeMode;

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    await ref.read(appPreferencesProvider).setThemeMode(mode);
  }
}