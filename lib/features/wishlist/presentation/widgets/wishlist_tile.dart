import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/cart/application/cart_actions.dart';
import 'package:e_commerce_app/features/products/application/product_repository_provider.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/price_text.dart';
import 'package:e_commerce_app/features/wishlist/application/wishlist_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WishlistTile extends ConsumerStatefulWidget {

  const WishlistTile({required this.product, super.key});

  final ProductSummary product;

  @override
  ConsumerState<WishlistTile> createState() => _WishlistTileState();
}

class _WishlistTileState extends ConsumerState<WishlistTile> {
  bool _busy = false;

  Future<void> _addToCart() async {
    final router = GoRouter.of(context);
    setState(() => _busy = true);

    try {
      final product = await ref
          .read(productRepositoryProvider)
          .getProductById(widget.product.id);
      final result = await ref.read(cartActionsProvider).add(product);
      if(!mounted) return;

      ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(
        result.limitReached ? 'Maximum quantity per item reached.'
            : 'Added to cart.',
      ),
      action: SnackBarAction(label: 'View cart',
          onPressed: () => router.goNamed(RouteNames.cart),
      ),),
      );
    } on Failure catch (failure) {
      if (mounted) context.showSnack(failure.message, isError: true);
    } finally {
      if(mounted) setState(() => _busy =false);
    }
  }

  Future<void> _remove() async {
    final actions = ref.read(wishlistActionsProvider);
    final messenger = ScaffoldMessenger.of(context);
    final product = widget.product;

    try {
      await actions.remove(product.id);
      messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: const Text(
          'Removed from whishlist'
        ),
        action:  SnackBarAction(label: 'Undo', onPressed: () => actions.toggle(product)),),

      );
    }
    on Failure catch (failure) {
      if (mounted) context.showSnack(failure.message, isError: true);
    }
  }

@override
Widget build(BuildContext context) {
    final product = widget.product;
    final colors = context.colors;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.openProduct(product.id),
        child: Padding(padding: const .all(12),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            ClipRRect(
              borderRadius: .circular(12),
              child: SizedBox.square(
                dimension: 96,
                child: ColoredBox(color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
                child: CachedNetworkImage(imageUrl: product.thumbnail,
                fit: BoxFit.contain,
                memCacheWidth: 250,
                errorWidget: (context, url, error) =>
                  Icon(Icons.image_not_supported_outlined,
                  color: colors.outline,
                  ),),),
              ),
            ),
            const SizedBox(width: 12,),
            Expanded(child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(child: Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleSmall,
                    ),),
                    IconButton(
                        tooltip: 'Remove from wishlist',
                        onPressed: _remove, icon: const Icon(
                      Icons.favorite_rounded,
                      size: 22,
                      color: AppColors.discount,
                    ),
                    visualDensity: .compact,
                    padding: .zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 32,
                      height: 32,

                    ),)

                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: AppColors.star,
                    ),
                    const SizedBox(width: 2,),
                    Text(
                      Formatters.rating(product.rating),
                      style: context.textTheme.bodySmall,
                    )
                  ],
                ),
                const SizedBox(height: 4,),
                PriceText(price: product.price,
                    discountPercentage: product.discountPercentage,
                ),
                const SizedBox(height: 8,),
                FilledButton.tonalIcon(onPressed: _busy ? null : _addToCart,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 40),

                    ),
                    icon: _busy
                    ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2,),
                    ) :
                    const Icon(Icons.shopping_cart_outlined, size: 18,),
                    label: const Text('Add to cart'),)
              ],
            ))
          ],
        ),),
      ),
    );
}




}