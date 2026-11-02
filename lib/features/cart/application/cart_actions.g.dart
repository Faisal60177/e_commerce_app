// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_actions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cartActions)
final cartActionsProvider = CartActionsProvider._();

final class CartActionsProvider
    extends $FunctionalProvider<CartActions, CartActions, CartActions>
    with $Provider<CartActions> {
  CartActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cartActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cartActionsHash();

  @$internal
  @override
  $ProviderElement<CartActions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CartActions create(Ref ref) {
    return cartActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CartActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CartActions>(value),
    );
  }
}

String _$cartActionsHash() => r'3fa178bba1a388bb324a63b4f624133541bdbbbb';
