import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/widgets/inline_error.dart';
import 'package:e_commerce_app/core/widgets/section_header.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/banner_slider.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/category_row.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:e_commerce_app/features/products/application/product_list_provider.dart';
import 'package:e_commerce_app/features/products/application/product_providers.dart';
import 'package:e_commerce_app/features/products/application/product_query.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_grid_sliver.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/product_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const _allProducts = ProductQuery();

  Future<void> _refresh(WidgetRef ref) async {
    ref
      ..invalidate(featuredProductsProvider)
      ..invalidate(dealProductsProvider)
      ..invalidate(newArrivalsProvider)
      ..invalidate(categoriesProvider)
      ..invalidate(productListProvider(_allProducts));

    try {
      await ref.read(productListProvider(_allProducts).future);
    } on Failure {
      return; // The grid shows its own error state with a retry button.
    }
  }

  bool _onScroll(ScrollNotification notification, WidgetRef ref) {
    if (notification.depth == 0 && notification.metrics.extentAfter < 600) {
      ref.read(productListProvider(_allProducts).notifier).loadMore();
    }
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featured = ref.watch(featuredProductsProvider);
    final deals = ref.watch(dealProductsProvider);
    final arrivals = ref.watch(newArrivalsProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) => _onScroll(notification, ref),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                floating: true,
                title: Text(
                  'ShopEase',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: context.colors.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                sliver: SliverToBoxAdapter(child: HomeSearchBar()),
              ),
              SliverToBoxAdapter(
                child: featured.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ShimmerBox(height: 180, radius: 20),
                  ),
                  error: (error, stackTrace) => InlineError(
                    message: failureMessage(error),
                    onRetry: () => ref.invalidate(featuredProductsProvider),
                  ),
                  data: (items) => BannerSlider(products: items),
                ),
              ),
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Categories',
                  onSeeAll: () => context.goNamed(RouteNames.categories),
                ),
              ),
              const SliverToBoxAdapter(child: CategoryRow()),
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'Top deals',
                  onSeeAll: () => context.openProductList(
                    'Top deals',
                    ProductSort.biggestDiscount,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ProductHorizontalList(
                  products: deals,
                  onRetry: () => ref.invalidate(dealProductsProvider),
                ),
              ),
              SliverToBoxAdapter(
                child: SectionHeader(
                  title: 'New arrivals',
                  onSeeAll: () => context.openProductList(
                    'New arrivals',
                    ProductSort.newest,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ProductHorizontalList(
                  products: arrivals,
                  onRetry: () => ref.invalidate(newArrivalsProvider),
                ),
              ),
              const SliverToBoxAdapter(
                child: SectionHeader(title: 'All products'),
              ),
              const ProductGridSliver(query: _allProducts),
            ],
          ),
        ),
      ),
    );
  }
}