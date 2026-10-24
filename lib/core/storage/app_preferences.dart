import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {

  AppPreferences(this._prefs);

  final SharedPreferences _prefs;

  static const _themekey = 'theme_mode';
  static const _recentSearchKey = 'recent_search';
  static const _maxRecentSearch = 8;

  ThemeMode get themeMode {
    final saved = _prefs.getString(_themekey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == saved,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_themekey, mode.name);
  }

  List<String> get recentSearches  =>
      _prefs.getStringList(_recentSearchKey) ?? const [];
  Future<void> addRecentSearch(String query) async {
    final value = query.trim();
    if(value.isEmpty) return;

    final updated = [
      value,
      ...recentSearches.where((e) => e.toLowerCase() != value.toLowerCase()),
    ].take(_maxRecentSearch).toList();

    await _prefs.setStringList(_recentSearchKey, updated);
  }

  Future<void> removeRecentSearch(String query) async {
    final updated = recentSearches.where((e) => e != query).toList();
    await _prefs.setStringList(_recentSearchKey, updated);
  }

  Future<void> clearRecentSearches() async {
    await _prefs.remove(_recentSearchKey);
  }


  }
