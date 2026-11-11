import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/widgets/app_empty_view.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/sign_in_prompt.dart';
import 'package:e_commerce_app/features/cart/application/cart_actions.dart';
import 'package:e_commerce_app/features/cart/application/cart_providers.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_totals.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_item_tile.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final _removing = <int>{};
  
  Future<void> _changedQuantity(CartItem item, int quantity) async {
    try {
      await ref.read(cartActionsProvider).setQuantity(item, quantity);
    } on Failure catch (failure) {
      if(mounted) context.showSnack(failure.message, isError: true);
    }
  }

  Future<void> _remove(CartItem item) async {
    setState(() => _removing.add(item.productId));
    final actions = ref.read(cartActionsProvider);

    try {
      await actions.remove(item.productId);
    } on Failure catch (failure) {
      if (!mounted) return;
      setState(() => _removing.remove(item.productId));
      context.showSnack(failure.message, isError: true);
      return;
    }

    if (!mounted) return;
    setState(() => _removing.remove(item.productId));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${item.title} removed'),
          action: SnackBarAction(label: 'Undo', onPressed: () => _restore(item)),
        ),
      );
  }

  Future<void> _restore(CartItem item) async {
    try {
      await ref.read(cartActionsProvider).restore(item);
    } on Failure catch (failure) {
      if (mounted) context.showSnack(failure.message, isError: true);
    }
  }
  
  Future<void> _confirmClear() async {
    final confirmed = await showDialog<bool>(
        context: context, 
        builder: (context) => AlertDialog(
          title: const Text ('Clear cart?'),
          content: const Text('All items will be removed from your cart.'),
          actions: [
            TextButton(onPressed: ()=> Navigator.pop(context,false),
                child: const Text('Cancel'),
            ),
            FilledButton(onPressed: () => Navigator.pop(context, true), 
                child: Text('Clear'),
            ),
            
          ],
        )
    );
    if(!(confirmed ?? false)) return;
    try {
      await ref.read(cartActionsProvider).clear();
    } on Failure catch (failure) {
      if(mounted) context.showSnack(failure.message, isError: true);
    }
  }

@override
Widget build(BuildContext context) {
    final uid = ref.watch(currentUidProvider);

    if(uid == null){
      return Scaffold(
        appBar: AppBar(title: const Text('Cart'),),
        body: const SignInPrompt(
            icon: Icons.shopping_cart_outlined,
            title: 'Sign in to view your cart',
            subtitle: 'Your cart is saved to your account and syncs across devices.',
        ),
      );
    }

    final cart = ref.watch(cartItemsProvider);
    final items = (cart.value ?? const <CartItem>[])
    .where((item) => !_removing.contains(item.productId)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          if(items.isNotEmpty)
            TextButton(onPressed: _confirmClear, child: const Text('Clear')),
        ],
      ),
      body: cart.when(
        loading: () => const _CartSkeleton(),
        error: (error, stackTrace) => AppErrorView(message: failureMessage(error),
        onRetry: ()=> ref.invalidate(cartItemsProvider),
        ),
        data: (_) => items.isEmpty ?
            AppEmptyView(icon: Icons.shopping_cart_outlined,
                title: 'Your cart is empty',
              subtitle: 'Browse products and add your favorites.',
            actionLabel: 'Start shopping',
            onAction: () => context.goNamed(RouteNames.home),
            ): ListView.separated(
          padding: const.all(16),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12,),
          itemBuilder: (context, index) {
            final item = items[index];
            return CartItemTile(
                item: item, 
                onTap: () => context.openProduct(item.productId),
                onQuantityChanged: (quantity) => 
              _changedQuantity(item, quantity), 
                onRemove: () => _remove(item),
            );
          }, 
            
            ),
      ),
      bottomNavigationBar: items.isEmpty ? null 
      : CartSummary(totals: CartTotals.from(items),
        onCheckout: () => context.pushNamed(RouteNames.checkout),
      ),
    );
}


}

class _CartSkeleton extends StatelessWidget {
  const _CartSkeleton();
@override
Widget build(BuildContext context) {
  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
      padding: const .all(16),
    itemCount: 4,
    separatorBuilder: (context, index) => const SizedBox(height: 12,),
    itemBuilder: (context, index) => 
    const ShimmerBox(height: 108, radius: 16,), 
      );
}
  
}