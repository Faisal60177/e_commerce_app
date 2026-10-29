// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductList)
final productListProvider = ProductListFamily._();

final class ProductListProvider
    extends $AsyncNotifierProvider<ProductList, ProductListState> {
  ProductListProvider._({
    required ProductListFamily super.from,
    required ProductQuery super.argument,
  }) : super(
         retry: null,
         name: r'productListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productListHash();

  @override
  String toString() {
    return r'productListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductList create() => ProductList();

  @override
  bool operator ==(Object other) {
    return other is ProductListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productListHash() => r'87afb906a99d6bc10e57482b4fecf9c31fcfd57f';

final class ProductListFamily extends $Family
    with
        $ClassFamilyOverride<
          ProductList,
          AsyncValue<ProductListState>,
          ProductListState,
          FutureOr<ProductListState>,
          ProductQuery
        > {
  ProductListFamily._()
    : super(
        retry: null,
        name: r'productListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductListProvider call(ProductQuery query) =>
      ProductListProvider._(argument: query, from: this);

  @override
  String toString() => r'productListProvider';
}

abstract class _$ProductList extends $AsyncNotifier<ProductListState> {
  late final _$args = ref.$arg as ProductQuery;
  ProductQuery get query => _$args;

  FutureOr<ProductListState> build(ProductQuery query);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProductListState>, ProductListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProductListState>, ProductListState>,
              AsyncValue<ProductListState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
