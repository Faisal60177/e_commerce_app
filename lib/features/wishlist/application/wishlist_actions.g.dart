// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_actions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(wishlistActions)
final wishlistActionsProvider = WishlistActionsProvider._();

final class WishlistActionsProvider
    extends
        $FunctionalProvider<WishlistActions, WishlistActions, WishlistActions>
    with $Provider<WishlistActions> {
  WishlistActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wishlistActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wishlistActionsHash();

  @$internal
  @override
  $ProviderElement<WishlistActions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WishlistActions create(Ref ref) {
    return wishlistActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WishlistActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WishlistActions>(value),
    );
  }
}

String _$wishlistActionsHash() => r'94c8bcd555d4bf0a8be90a47b0de22e92c3211f1';
