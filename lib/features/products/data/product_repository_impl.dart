import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/constants/api_constants.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/models/paginated.dart';
import 'package:e_commerce_app/core/network/network_exceptions.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_category.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl  implements ProductRepository{
  ProductRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<Paginated<ProductSummary>> getProducts({
    int limit = ApiConstants.defaultPageSize,
    int skip = 0,
    ProductSort sort = ProductSort.relevance,

}) {
    return _fetchPage(
      ApiConstants.product,
      limit: limit,
      skip: skip,
      sort : sort

    );
  }

  @override
  Future<Paginated<ProductSummary>> getProductsByCategory(
      String slug, {
        int limit = ApiConstants.defaultPageSize,
        int skip = 0,
        ProductSort sort = ProductSort.relevance
  }) {
    return _fetchPage(
      ApiConstants.productByCategory(slug),
      limit: limit,
      skip : skip,
      sort : sort,
    );

  }

  @override
  Future<Paginated<ProductSummary>> searchProducts(
      String query, {
        int limit = ApiConstants.defaultPageSize,
        int skip = 0,
        ProductSort sort = ProductSort.relevance,
      }) {
    return _fetchPage(
      ApiConstants.productSearch,
      limit: limit,
      skip: skip,
      sort: sort,
      extraQuery: {'q': query},
    );
  }

  @override
  Future<Product> getProductById(int id) {
    return guardApi(() async {
      final json = await _get<Map<String,dynamic>>(
        ApiConstants.productById(id),
      );
      return Product.fromJson(json);
    });
  }

  @override
  Future<List<ProductCategory>> getCategories() {
    return guardApi(() async {
      final json = await _get<List<dynamic>>(ApiConstants.categories);
      return json.map((e) => ProductCategory.fromJson(e as Map<String, dynamic>)).toList();

    });
  }

  Future<Paginated<ProductSummary>> _fetchPage(
      String path, {
        required int limit,
        required int skip,
        required ProductSort sort,
        Map<String ,dynamic> extraQuery = const{},
  }) {
    return guardApi(() async {
      final json = await _get<Map<String, dynamic>>(
        path,
        query: {
          'limit' : limit,
          'skip' : skip,
          'select' : ApiConstants.summaryFields,
          ...sort.queryParameters,
          ...extraQuery,
        },
      );

      return Paginated(
        items: (json['products'] as List<dynamic>)
            .map((e) => ProductSummary.fromJson(e as Map<String, dynamic>)).toList(),
        total: json['total'] as int,
        skip: json['skip'] as int,
        limit: json['limit'] as int,
      );
    });
  }

  Future<T> _get<T>(String path, {Map<String, dynamic>? query}) async {
    final response = await _dio.get<T>(path, queryParameters: query);
    final data = response.data;
    if(data == null) {
      throw const UnknownFailure('Empty response from the server.');
    }
    return data;
  }

}