import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:e_commerce_app/features/products/application/product_detail_providers.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/add_to_cart_bar.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/image_gallery.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/price_text.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_info_section.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/related_products.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/review_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({required this.productId, super.key});

  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final product = ref.watch(productDetailProvider(productId));
    final data = product.value;

    return Scaffold(
      appBar: AppBar(),
      body: product.when(
        loading: () => const _DetailSkeleton(),
        error: (error, stackTrace) => AppErrorView(
          message: failureMessage(error),
          onRetry: () => ref.invalidate(productDetailProvider(productId)),
        ),
        data: (product) => _DetailBody(product: product),
      ),
      bottomNavigationBar: data == null ? null : AddToCartBar(product: data),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colors = context.colors;
    final images = product.images.isEmpty && product.thumbnail.isNotEmpty
        ? [product.thumbnail]
        : product.images;
    final saved = product.price - product.discountedPrice;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageGallery(images: images),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.brand != null) ...[
                  Text(
                    product.brand!.toUpperCase(),
                    style: textTheme.labelMedium?.copyWith(
                      color: colors.primary,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                Text(product.title, style: textTheme.headlineSmall),
                const SizedBox(height: 12),
                Row(
                  children: [
                    StarRating(rating: product.rating),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${Formatters.rating(product.rating)} '
                            '(${product.reviews.length} reviews)',
                        style: textTheme.bodyMedium,
                      ),
                    ),
                    _StockChip(product: product),
                  ],
                ),
                const SizedBox(height: 16),
                PriceText(
                  price: product.price,
                  discountPercentage: product.discountPercentage,
                  large: true,
                ),
                if (product.hasDiscount) ...[
                  const SizedBox(height: 4),
                  Text(
                    'You save ${Formatters.price(saved)} '
                        '(${Formatters.discount(product.discountPercentage)})',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Text('Description', style: textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  product.description,
                  style: textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
                if (product.tags.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final tag in product.tags)
                        Chip(
                          label: Text(tag),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                ],
                const SizedBox(height: 20),
                Text('Details', style: textTheme.titleMedium),
                const SizedBox(height: 8),
                ProductInfoSection(product: product),
                const SizedBox(height: 24),
                Text(
                  'Reviews (${product.reviews.length})',
                  style: textTheme.titleLarge,
                ),
              ],
            ),
          ),
          if (product.reviews.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('No reviews yet.', style: textTheme.bodyMedium),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  for (var i = 0; i < product.reviews.length; i++) ...[
                    if (i > 0) const Divider(),
                    ReviewTile(review: product.reviews[i]),
                  ],
                ],
              ),
            ),
          RelatedProducts(category: product.category, productId: product.id),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _StockChip extends StatelessWidget {
  const _StockChip({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final (label, color) = !product.isInStock
        ? ('Out of stock', context.colors.error)
        : product.isLowStock
        ? ('Only ${product.stock} left', AppColors.warning)
        : ('In stock', AppColors.success);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(height: 320, radius: 0),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerBox(width: 80, height: 12),
                SizedBox(height: 8),
                ShimmerBox(height: 24),
                SizedBox(height: 16),
                ShimmerBox(width: 120, height: 20),
                SizedBox(height: 24),
                ShimmerBox(height: 14),
                SizedBox(height: 8),
                ShimmerBox(height: 14),
                SizedBox(height: 8),
                ShimmerBox(width: 200, height: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}