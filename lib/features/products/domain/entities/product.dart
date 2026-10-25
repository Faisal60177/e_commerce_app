import 'package:e_commerce_app/core/utils/price_utils.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_dimensions.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_meta.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_review.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    required String description,
    required String category,
    required double price,
    @Default(0.0) double discountPercentage,
    @Default(0.0) double rating,
    @Default(0) int stock,
    @Default([]) List<String> tags,
    String? brand,
    String? sku,
    double? weight,
    ProductDimensions? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    @Default([]) List<ProductReview> reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    ProductMeta? meta,
    @Default([]) List<String> images,
    @Default('') String thumbnail,
}) = _Product;

  const Product._();

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  bool get hasDiscount => discountPercentage > 0;

  double get discountedPrice => PriceUtils.applyDiscount(price, discountPercentage);

  bool get isInStock => stock > 0;

  bool get isLowStock => stock > 0 && stock <= 5;

  String get coverImage => images.isNotEmpty ? images.first : thumbnail;

  ProductSummary toSummary() => ProductSummary(
      id: id,
      title: title,
      price: price,
      thumbnail: thumbnail,
      rating: rating,
      discountPercentage: discountPercentage,);


}