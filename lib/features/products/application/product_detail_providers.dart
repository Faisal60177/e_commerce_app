import 'package:e_commerce_app/features/products/application/product_repository_provider.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_detail_providers.g.dart';

@riverpod
Future<Product> productDetail(Ref ref, int id) {
  return ref.watch(productRepositoryProvider).getProductById(id);
}

@riverpod
Future<List<ProductSummary>> relatedProducts(
    Ref ref,
    String category,
    int excludeId,
    ) async {
  final page = await ref
      .watch(productRepositoryProvider)
      .getProductsByCategory(category, limit: 11);
  return page.items.where((p) => p.id != excludeId).take(10).toList();
}