import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/app/shell/main_shell.dart';
import 'package:e_commerce_app/core/widgets/placeholder_screen.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:e_commerce_app/features/products/presentation/screens/categories_screen.dart';
import 'package:e_commerce_app/features/products/presentation/screens/product_detail_screen.dart';
import 'package:e_commerce_app/features/products/presentation/screens/product_list_screen.dart';
import 'package:e_commerce_app/features/products/presentation/screens/search_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final router = GoRouter(
    initialLocation: RoutePaths.home,
    debugLogDiagnostics: kDebugMode,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => MainShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.home,
                name: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.categories,
                name: RouteNames.categories,
                builder: (context, state) => const CategoriesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.cart,
                name: RouteNames.cart,
                builder: (context, state) =>
                const PlaceholderScreen(title: 'Cart'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.wishlist,
                name: RouteNames.wishlist,
                builder: (context, state) =>
                const PlaceholderScreen(title: 'Wishlist'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.account,
                name: RouteNames.account,
                builder: (context, state) =>
                const PlaceholderScreen(title: 'Account'),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.search,
        name: RouteNames.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: RoutePaths.productDetail,
        name: RouteNames.productDetail,
        builder: (context, state) => ProductDetailScreen(
          productId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
        ),
      ),
      GoRoute(
        path: RoutePaths.categoryProducts,
        name: RouteNames.categoryProducts,
        builder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          return ProductListScreen(
            title: (state.extra as String?) ?? slug,
            category: slug,
          );
        },
      ),
      GoRoute(
        path: RoutePaths.productList,
        name: RouteNames.productList,
        builder: (context, state) {
          final sortName = state.pathParameters['sort'] ?? '';
          final sort = ProductSort.values.firstWhere(
                (s) => s.name == sortName,
            orElse: () => ProductSort.relevance,
          );
          return ProductListScreen(
            title: (state.extra as String?) ?? 'Products',
            initialSort: sort,
          );
        },
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
}