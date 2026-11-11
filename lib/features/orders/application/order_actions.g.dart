// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_actions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(orderActions)
final orderActionsProvider = OrderActionsProvider._();

final class OrderActionsProvider
    extends $FunctionalProvider<OrderActions, OrderActions, OrderActions>
    with $Provider<OrderActions> {
  OrderActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'orderActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$orderActionsHash();

  @$internal
  @override
  $ProviderElement<OrderActions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OrderActions create(Ref ref) {
    return orderActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrderActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrderActions>(value),
    );
  }
}

String _$orderActionsHash() => r'ab61ebf7482e54fcaf01dd2737f28d8fe2587435';
