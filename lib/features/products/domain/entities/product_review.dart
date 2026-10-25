import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_review.freezed.dart';
part 'product_review.g.dart';

@freezed
abstract class ProductReview with _$ProductReview {
  const factory ProductReview({
    required int rating,
    required DateTime date,
    @Default('') String comment,
    @Default('Anonymous') String reviewerName,
    String? reviewerEmail,
  }) = _ProductReview;

  factory ProductReview.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewFromJson(json);
}