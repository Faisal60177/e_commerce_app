import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_query.freezed.dart';

@freezed
abstract class ProductQuery with _$ProductQuery {
  const factory ProductQuery({
    String? category,
    String? search,
    @Default(ProductSort.relevance) ProductSort sort,
  }) = _ProductQuery;
}
