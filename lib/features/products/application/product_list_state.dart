import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_list_state.freezed.dart';

@freezed
abstract class ProductListState with _$ProductListState {
  const factory ProductListState({
    required List<ProductSummary> items,
    required int total,
    @Default(false) bool isLoadingMore,
    Failure? loadMoreError,
}) = _ProductListState;

  const ProductListState._();

  bool get hasMore => items.length < total;

}