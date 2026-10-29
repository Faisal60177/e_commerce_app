import 'package:e_commerce_app/features/products/application/product_repository_provider.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_category.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_providers.g.dart';

@riverpod
Future<List<ProductSummary>> featuredProducts(Ref ref) async {
  final page = await ref
      .watch(productRepositoryProvider)
      .getProducts(limit: 5, sort: ProductSort.topRated);
  return page.items;
}

@riverpod
Future<List<ProductSummary>> dealProducts(Ref ref) async {
  final page = await ref
      .watch(productRepositoryProvider)
      .getProducts(limit: 10, sort: ProductSort.biggestDiscount);
  return page.items;
}

@riverpod
Future<List<ProductSummary>> newArrivals(Ref ref) async {
  final page = await ref
      .watch(productRepositoryProvider)
      .getProducts(limit: 10, sort: ProductSort.newest);
  return page.items;
}

@Riverpod(keepAlive: true)
Future<List<ProductCategory>> categories(Ref ref) async {
  return ref.watch(productRepositoryProvider).getCategories();
}