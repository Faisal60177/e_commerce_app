import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recent_searches_provider.g.dart';

@Riverpod(keepAlive: true)
class RecentSearches extends _$RecentSearches {
  @override
  List<String> build() => ref.read(appPreferencesProvider).recentSearches;

  Future<void> add(String query) async {
    final prefs = ref.read(appPreferencesProvider);
    await prefs.addRecentSearch(query);
    state = prefs.recentSearches;
  }

  Future<void> remove(String query) async {
    final prefs = ref.read(appPreferencesProvider);
    await prefs.removeRecentSearch(query);
    state = prefs.recentSearches;
  }

  Future<void> clear() async {
    final prefs = ref.read(appPreferencesProvider);
    await prefs.clearRecentSearches();
    state = prefs.recentSearches;
  }
}