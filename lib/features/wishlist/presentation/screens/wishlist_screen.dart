import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/widgets/app_empty_view.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/sign_in_prompt.dart';
import 'package:e_commerce_app/features/wishlist/application/wishlist_providers.dart';
import 'package:e_commerce_app/features/wishlist/presentation/widgets/wishlist_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WishlistScreen extends ConsumerWidget {

const WishlistScreen({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
  final uid = ref.watch(currentUidProvider);

  if(uid == null) {
    return Scaffold(
      appBar:  AppBar(title: const Text('Wishlist'),),
      body: const SignInPrompt(
          icon: Icons.favorite_border_rounded,
          title: 'Sign in to see your wishlist', subtitle: 'Save products you love and find them here anytime.',
      ),
    );
  }

  final wishlist = ref.watch(wishlistItemsProvider);
  final count = wishlist.value?.length ?? 0;

  return Scaffold(
    appBar:  AppBar(
      title:  Text(count > 0 ? 'Wishlist ($count)' : 'Wishlist'),
    ),
    body: wishlist.when(
      loading: () => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
          padding:  const .all(16),
        itemCount: 4,
        separatorBuilder: (context, index) => const SizedBox(height: 12,),
          itemBuilder: (context, index) =>
        const ShimmerBox(height: 120, radius: 16,),
      ),
      error: (error , stackTrace) => AppErrorView(
          message: failureMessage(error),
      onRetry: () => ref.invalidate(wishlistItemsProvider),
      ),
      data : (items) => items.isEmpty
        ? AppEmptyView(icon: Icons.favorite_border_rounded,
          title: 'Your wishlist is empty',
        subtitle: 'Tap the heart on any product to save it here.',
        actionLabel: 'Explore products',
      onAction:  () => context.goNamed(RouteNames.home),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder:  (context, index) =>
        WishlistTile(product: items[index]),
      )
    ),
  );
}



}