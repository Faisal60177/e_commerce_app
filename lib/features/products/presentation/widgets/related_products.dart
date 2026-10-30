import 'package:e_commerce_app/core/widgets/section_header.dart';
import 'package:e_commerce_app/features/products/application/product_detail_providers.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RelatedProducts extends ConsumerWidget {
  const RelatedProducts({
    required this.category,
    required this.productId,
    super.key,
  });

  final String category;
  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final related = ref.watch(relatedProductsProvider(category, productId));

    if (related.value?.isEmpty ?? false) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'You may also like'),
        ProductHorizontalList(
          products: related,
          onRetry: () =>
              ref.invalidate(relatedProductsProvider(category, productId)),
        ),
      ],
    );
  }
}