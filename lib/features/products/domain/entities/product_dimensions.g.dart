// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dimensions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductDimensions _$ProductDimensionsFromJson(Map<String, dynamic> json) =>
    _ProductDimensions(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductDimensionsToJson(_ProductDimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'depth': instance.depth,
    };
