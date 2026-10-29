import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/widgets/app_empty_view.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/features/products/application/product_list_provider.dart';
import 'package:e_commerce_app/features/products/application/product_list_state.dart';
import 'package:e_commerce_app/features/products/application/product_query.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_card.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductGridSliver extends ConsumerWidget {

  const ProductGridSliver({
    required this.query,
    this.emptyTitle = 'No products found',
    this.emptySubtitle,
    super.key,
  });

  final ProductQuery query;
  final String emptyTitle;
  final String? emptySubtitle;

  static const _delegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    mainAxisExtent: ProductCard.height,
  );


@override
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(productListProvider(query));
  
  return state.when(
    loading: () => SliverPadding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
    sliver: SliverGrid.builder(gridDelegate: _delegate, itemCount: 6, itemBuilder: (context, index) => const ProductCardSkeleton(),
    
    ),
    ),
    error: (error, stackTrace) => SliverToBoxAdapter(
      child: Padding(padding: const EdgeInsets.only(top: 48),
      child: AppErrorView(message: failureMessage(error),
      onRetry: () => ref.invalidate(productListProvider(query)),
      ),
      ),
    ),
    data : (data) {
      if(data.items.isEmpty){
        return SliverFillRemaining(
          hasScrollBody: false,
          child: AppEmptyView(icon: Icons.search_off_rounded, title: emptyTitle, subtitle: emptySubtitle,
          ),
        );
      }
      
      return SliverMainAxisGroup(slivers: [
        SliverPadding(padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid.builder(
            gridDelegate: _delegate,
            itemCount: data.items.length, itemBuilder: (context, index) {
              final product = data.items[index];
              return ProductCard(product: product, onTap: () => context.openProduct(product.id),
              );
        },

        ),
        ),

        SliverToBoxAdapter(
          child: _GridFooter(
            state: data,
            onRetry: () =>
                ref.read(productListProvider(query).notifier).loadMore(),
          ),
        )
      ],
      );
    }
  );
  
}


}

class _GridFooter extends StatelessWidget {

  const _GridFooter({required this.state, required this.onRetry});

  final ProductListState state;
  final VoidCallback onRetry;

@override
Widget build(BuildContext context) {
  if(state.isLoadingMore) {
    return const Padding(padding: EdgeInsets.all(24),
    child: Center(child: CircularProgressIndicator()),
    );
  }
  
  if(state.loadMoreError != null) {
    return Padding(padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        Text(state.loadMoreError!.message),
        TextButton(onPressed: onRetry, child: const Text('Retry')),
      ],
    ),
    );
  }
  if(!state.hasMore) {
    return Padding(padding: const EdgeInsets.all(24),
    child: Center(
      child: Text("You've reached the end", style: context.textTheme.bodySmall?.copyWith(color: context.colors.outline,
      ),
      ),
    ),
    );
  }
  return const SizedBox(height: 24,);
  
}


}