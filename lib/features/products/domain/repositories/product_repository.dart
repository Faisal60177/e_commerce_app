import 'package:e_commerce_app/core/constants/api_constants.dart';
import 'package:e_commerce_app/core/models/paginated.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_category.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';

abstract interface class ProductRepository {
  Future<Paginated<ProductSummary>> getProducts({
    int limit = ApiConstants.defaultPageSize,
    int skip = 0,
    ProductSort sort = ProductSort.relevance,
});

  Future<Paginated<ProductSummary>> getProductsByCategory(
      String slug, {
        int limit = ApiConstants.defaultPageSize,
        int skip = 0,
        ProductSort sort = ProductSort.relevance,

  });

  Future<Paginated<ProductSummary>> searchProducts(
      String query, {
        int limit = ApiConstants.defaultPageSize,
        int skip = 0,
        ProductSort sort = ProductSort.relevance,
      });

  Future<Product> getProductById(int id);

  Future<List<ProductCategory>> getCategories();




}