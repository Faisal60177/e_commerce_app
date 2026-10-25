// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductReview _$ProductReviewFromJson(Map<String, dynamic> json) =>
    _ProductReview(
      rating: (json['rating'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      comment: json['comment'] as String? ?? '',
      reviewerName: json['reviewerName'] as String? ?? 'Anonymous',
      reviewerEmail: json['reviewerEmail'] as String?,
    );

Map<String, dynamic> _$ProductReviewToJson(_ProductReview instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'date': instance.date.toIso8601String(),
      'comment': instance.comment,
      'reviewerName': instance.reviewerName,
      'reviewerEmail': instance.reviewerEmail,
    };
