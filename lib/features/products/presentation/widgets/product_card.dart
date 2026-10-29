import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/price_text.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget{

  static const height = 272.0;
  const ProductCard({
    required this.product,
    required this.onTap,
    this.overlayAction,
    super.key,
  });




  final ProductSummary product;
  final VoidCallback onTap;
  final Widget? overlayAction;

@override
Widget build(BuildContext context) {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Expanded(child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: context.colors.surfaceContainerHighest.withValues(alpha: 0.5),
            child: Padding(padding: const EdgeInsets.all(8),
            child: CachedNetworkImage(imageUrl: product.thumbnail,
            fit: BoxFit.contain,
              memCacheWidth: 400,
              placeholder: (context, url) =>
              const ShimmerBox(radius: 0),
              errorWidget: (context, url, error) => Icon(
                Icons.image_not_supported_outlined,
                color: context.colors.outline,
              ),
            ),
            ),
            ),
            if(product.hasDiscount)
              Positioned(top: 8, left: 8,
              child: _DiscountBadge
                (label: Formatters.discount(product.discountPercentage),
              ),
              ),

            if(overlayAction != null)
              Positioned(top: 4, right: 4, child: overlayAction!),
          ],
        ),
        ),
          Padding(padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(product.title,
              maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleSmall,
              ),
              const SizedBox(height: 4,),
              Row(
                children: [
                  const Icon(Icons.star_rounded, size: 16, color: AppColors.star,),
                  const SizedBox(width: 2),
                  Text(Formatters.rating(product.rating),
                  style: context.textTheme.bodySmall,),

                ],
              ),
              const SizedBox(height: 4),
              PriceText(price: product.price, discountPercentage: product.discountPercentage,
              ),

            ],
          ),
          )
        ],
      ),
    ),
  );
}
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.label});

  final String label;

@override
Widget build(BuildContext context) {
  return DecoratedBox(decoration: BoxDecoration(
    color: AppColors.discount,
    borderRadius: BorderRadius.circular(8),
  ),
    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
    child: Text(label,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 11,
      fontWeight: FontWeight.w700,
    ),
    ),
    ),

  );

}

}