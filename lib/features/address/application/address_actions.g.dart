// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_actions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(addressActions)
final addressActionsProvider = AddressActionsProvider._();

final class AddressActionsProvider
    extends $FunctionalProvider<AddressActions, AddressActions, AddressActions>
    with $Provider<AddressActions> {
  AddressActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addressActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addressActionsHash();

  @$internal
  @override
  $ProviderElement<AddressActions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddressActions create(Ref ref) {
    return addressActions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddressActions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddressActions>(value),
    );
  }
}

String _$addressActionsHash() => r'545326924eb8aa68c49f501a795a12cfb7cd5214';
