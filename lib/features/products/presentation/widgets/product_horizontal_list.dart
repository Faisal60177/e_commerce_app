import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/widgets/inline_error.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_card.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductHorizontalList extends StatelessWidget {
  const ProductHorizontalList({
    required this.products,
    required this.onRetry,
    super.key,
  });

  final AsyncValue<List<ProductSummary>> products;
  final VoidCallback onRetry;

  static const _cardWidth = 160.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ProductCard.height,
      child: products.when(
        loading: () => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) => const SizedBox(
            width: _cardWidth,
            child: ProductCardSkeleton(),
          ),
        ),
        error: (error, stackTrace) =>
            InlineError(message: failureMessage(error), onRetry: onRetry),
        data: (items) => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final product = items[index];
            return SizedBox(
              width: _cardWidth,
              child: ProductCard(
                product: product,
                onTap: () => context.openProduct(product.id),
              ),
            );
          },
        ),
      ),
    );
  }
}