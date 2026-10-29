// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(featuredProducts)
final featuredProductsProvider = FeaturedProductsProvider._();

final class FeaturedProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductSummary>>,
          List<ProductSummary>,
          FutureOr<List<ProductSummary>>
        >
    with
        $FutureModifier<List<ProductSummary>>,
        $FutureProvider<List<ProductSummary>> {
  FeaturedProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featuredProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featuredProductsHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductSummary>> create(Ref ref) {
    return featuredProducts(ref);
  }
}

String _$featuredProductsHash() => r'bb266df2a28e1244c18a28c63d976cdfe49490f2';

@ProviderFor(dealProducts)
final dealProductsProvider = DealProductsProvider._();

final class DealProductsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductSummary>>,
          List<ProductSummary>,
          FutureOr<List<ProductSummary>>
        >
    with
        $FutureModifier<List<ProductSummary>>,
        $FutureProvider<List<ProductSummary>> {
  DealProductsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dealProductsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dealProductsHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductSummary>> create(Ref ref) {
    return dealProducts(ref);
  }
}

String _$dealProductsHash() => r'cd53278b4dee3b0669ad9e3ceccde252ed0beda3';

@ProviderFor(newArrivals)
final newArrivalsProvider = NewArrivalsProvider._();

final class NewArrivalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductSummary>>,
          List<ProductSummary>,
          FutureOr<List<ProductSummary>>
        >
    with
        $FutureModifier<List<ProductSummary>>,
        $FutureProvider<List<ProductSummary>> {
  NewArrivalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newArrivalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newArrivalsHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductSummary>> create(Ref ref) {
    return newArrivals(ref);
  }
}

String _$newArrivalsHash() => r'a1c088aab7f8a0e80679b1df84641dab3fa05d47';

@ProviderFor(categories)
final categoriesProvider = CategoriesProvider._();

final class CategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProductCategory>>,
          List<ProductCategory>,
          FutureOr<List<ProductCategory>>
        >
    with
        $FutureModifier<List<ProductCategory>>,
        $FutureProvider<List<ProductCategory>> {
  CategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<ProductCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProductCategory>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'a931cc08cd574e99fa7c39f01426b44a8a2d00b8';
