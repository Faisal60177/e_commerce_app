// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(wishlistRepository)
final wishlistRepositoryProvider = WishlistRepositoryProvider._();

final class WishlistRepositoryProvider
    extends
        $FunctionalProvider<
          WishlistRepository,
          WishlistRepository,
          WishlistRepository
        >
    with $Provider<WishlistRepository> {
  WishlistRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wishlistRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wishlistRepositoryHash();

  @$internal
  @override
  $ProviderElement<WishlistRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WishlistRepository create(Ref ref) {
    return wishlistRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WishlistRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WishlistRepository>(value),
    );
  }
}

String _$wishlistRepositoryHash() =>
    r'bbf1ea8f6296727a020656f5bf624898715d1853';

@ProviderFor(wishlistItems)
final wishlistItemsProvider = WishlistItemsProvider._();

final class WishlistItemsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductSummary>>,
          List<ProductSummary>,
          Stream<List<ProductSummary>>
        >
    with
        $FutureModifier<List<ProductSummary>>,
        $StreamProvider<List<ProductSummary>> {
  WishlistItemsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wishlistItemsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wishlistItemsHash();

  @$internal
  @override
  $StreamProviderElement<List<ProductSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<ProductSummary>> create(Ref ref) {
    return wishlistItems(ref);
  }
}

String _$wishlistItemsHash() => r'11e08061947b0fd93dcaf66fcdbdc7824bf1d998';

@ProviderFor(wishlistIds)
final wishlistIdsProvider = WishlistIdsProvider._();

final class WishlistIdsProvider
    extends $FunctionalProvider<Set<int>, Set<int>, Set<int>>
    with $Provider<Set<int>> {
  WishlistIdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wishlistIdsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wishlistIdsHash();

  @$internal
  @override
  $ProviderElement<Set<int>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Set<int> create(Ref ref) {
    return wishlistIds(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<int>>(value),
    );
  }
}

String _$wishlistIdsHash() => r'ade62ead01131a65d7f92f002056c99d3cee4db2';
