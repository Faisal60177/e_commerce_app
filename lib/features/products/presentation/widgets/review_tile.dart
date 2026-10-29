import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_review.dart';
import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {

  const StarRating({required this.rating, this.size = 16, super.key});

  final double rating;
  final double size;

@override
Widget build(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      final icon = rating >= index + 1
          ? Icons.start_rounded
          : rating >= index + 0.5
          ? Icons.star_half_rounded
          : Icons.star_outline_rounded;
      return Icon(icon, size: size, color: AppColors.star,);
    }),
  );
}
}

class ReviewTile extends StatelessWidget {
  const ReviewTile({required this.review, super.key});
  final ProductReview review;

@override
Widget build(BuildContext context) {
  final name = review.reviewerName;

  return Padding(padding: const EdgeInsets.symmetric(vertical: 12),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 20,
        backgroundColor: context.colors.primaryContainer,
        child: Text(name.isEmpty ? '?' : name[0].toUpperCase(),
        style: TextStyle(color: context.colors.onPrimaryContainer),
        ),
      ),
      const SizedBox(width: 12,),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Expanded(child: Text(name, style: context.textTheme.titleLarge,),
            ),
            Text(Formatters.date(review.date),
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.outline,
            ),
            ),
          ],
        ),
        const SizedBox(height: 4,),
        StarRating(rating: review.rating.toDouble()),
        if(review.comment.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(review.comment, style: context.textTheme.bodyMedium,)
        ]
      ],
      )
      )
    ],
  ),
  );
}


}
