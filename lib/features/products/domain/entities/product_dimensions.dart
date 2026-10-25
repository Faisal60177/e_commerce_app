import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_dimensions.freezed.dart';
part 'product_dimensions.g.dart';

@freezed
abstract class ProductDimensions  with _$ProductDimensions{

  const factory ProductDimensions({
    required double width,
    required double height,
    required double depth,
}) = _ProductDimensions;

  factory ProductDimensions.fromJson(Map<String, dynamic> json) =>
      _$ProductDimensionsFromJson(json);
}
