// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(productDetail)
final productDetailProvider = ProductDetailFamily._();

final class ProductDetailProvider
    extends $FunctionalProvider<AsyncValue<Product>, Product, FutureOr<Product>>
    with $FutureModifier<Product>, $FutureProvider<Product> {
  ProductDetailProvider._({
    required ProductDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'productDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$productDetailHash();

  @override
  String toString() {
    return r'productDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Product> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Product> create(Ref ref) {
    final argument = this.argument as int;
    return productDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productDetailHash() => r'448596189c6f5d86d85d486b64601809232ebd20';

final class ProductDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Product>, int> {
  ProductDetailFamily._()
    : super(
        retry: null,
        name: r'productDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProductDetailProvider call(int id) =>
      ProductDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'productDetailProvider';
}

@ProviderFor(relatedProducts)
final relatedProductsProvider = RelatedProductsFamily._();

final class RelatedProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductSummary>>,
          List<ProductSummary>,
          FutureOr<List<ProductSummary>>
        >
    with
        $FutureModifier<List<ProductSummary>>,
        $FutureProvider<List<ProductSummary>> {
  RelatedProductsProvider._({
    required RelatedProductsFamily super.from,
    required (String, int) super.argument,
  }) : super(
         retry: null,
         name: r'relatedProductsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$relatedProductsHash();

  @override
  String toString() {
    return r'relatedProductsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<ProductSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductSummary>> create(Ref ref) {
    final argument = this.argument as (String, int);
    return relatedProducts(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is RelatedProductsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$relatedProductsHash() => r'9147b8ba48f0fc0a07b26e26fd3c666588ec9b2a';

final class RelatedProductsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<ProductSummary>>,
          (String, int)
        > {
  RelatedProductsFamily._()
    : super(
        retry: null,
        name: r'relatedProductsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RelatedProductsProvider call(String category, int excludeId) =>
      RelatedProductsProvider._(argument: (category, excludeId), from: this);

  @override
  String toString() => r'relatedProductsProvider';
}
