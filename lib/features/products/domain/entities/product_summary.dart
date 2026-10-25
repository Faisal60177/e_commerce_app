import 'package:e_commerce_app/core/utils/price_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_summary.freezed.dart';
part 'product_summary.g.dart';


@freezed
abstract class ProductSummary with _$ProductSummary {
  const factory ProductSummary({
    required int id,
    required String title,
    required double price,
    @Default('') String thumbnail,
    @Default(0.0) double rating,
    @Default(0.0) double discountPercentage,
  }) = _ProductSummary;

  const ProductSummary._();

  factory ProductSummary.fromJson(Map<String, dynamic> json) =>
      _$ProductSummaryFromJson(json);

  bool get hasDiscount =>  discountPercentage > 0;

  double get discountedPrice =>
        PriceUtils.applyDiscount(price, discountPercentage);
}