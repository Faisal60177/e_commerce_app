import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_meta.freezed.dart';
part 'product_meta.g.dart';

@freezed
abstract class  ProductMeta  with _$ProductMeta{
  const factory ProductMeta({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? barcode,
    String? qrCode,
}) = _ProductMeta;

  factory ProductMeta.fromJson(Map<String, dynamic> json) =>
      _$ProductMetaFromJson(json);

}