import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/auth/application/require_auth.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:e_commerce_app/features/wishlist/application/wishlist_actions.dart';
import 'package:e_commerce_app/features/wishlist/application/wishlist_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistButton  extends ConsumerWidget{
  const WishlistButton({required this.product, this.onCard = true, super.key});
  
  final ProductSummary product;
  final bool onCard;
  
  Future<void> _toggle(BuildContext context, WidgetRef ref) async {
    final signedIn = await ref.ensureSignedIn(context);
    if(!signedIn || !context.mounted) return;
    
    try {
      final saved = await ref.read(wishlistActionsProvider).toggle(product);
      if(context.mounted){
        context.showSnack(saved ? 'Saved to wishlist' : 'Removed from wishlist');
      }
    } on Failure catch(failure) {
      if(context.mounted) context.showSnack(failure.message, isError: true);
    }
  }
  @override
Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(
      wishlistIdsProvider.select((ids) => ids.contains(product.id)),
    );

    final icon = AnimatedSwitcher(duration: const Duration(milliseconds: 200),
    transitionBuilder: (child, animation) =>
      ScaleTransition(scale: animation, child: child,),
    child: Icon(saved? Icons.favorite_rounded : Icons.favorite_border_rounded,
    key: ValueKey(saved),
    size: onCard ? 20 : 24,
    color: saved ? AppColors.discount : null,
    ),);

    final button = IconButton(
        tooltip: saved ? 'Remove from wishlist' : 'Add to wishlist',
        onPressed: ()=> _toggle(context, ref),
        icon: icon,
    padding:  .zero,
    constraints: onCard ? const BoxConstraints.tightFor(width: 34,height: 34) :  null ,);

    if(!onCard) return button;

    return Material(
      color: context.colors.surface.withValues(alpha: 0.9),
      shape: const CircleBorder(),
      child: button,
    );
  }
}