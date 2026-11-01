import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/app/shell/main_shell.dart';
import 'package:e_commerce_app/core/widgets/placeholder_screen.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/verify_email_screen.dart';
import 'package:e_commerce_app/features/home/presentation/screens/home_screen.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_sort.dart';
import 'package:e_commerce_app/features/products/presentation/screens/categories_screen.dart';
import 'package:e_commerce_app/features/products/presentation/screens/product_detail_screen.dart';
import 'package:e_commerce_app/features/products/presentation/screens/product_list_screen.dart';
import 'package:e_commerce_app/features/products/presentation/screens/search_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/screens/account_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

const _protectedPrefixes = ['/checkout', '/orders', '/addresses'];

class _AuthRefresh extends ChangeNotifier {
  void notify() => notifyListeners();
}

String? _redirect(Ref ref, GoRouterState state) {
  final auth = ref.read(authUserProvider);
  if (!auth.hasValue) return null;
  final user = auth.value;
  final location = state.matchedLocation;

  if (user == null) {
    if (location == RoutePaths.verifyEmail) return RoutePaths.login;
    final needsAuth = _protectedPrefixes.any(location.startsWith);
    if (needsAuth) {
      return Uri(
        path: RoutePaths.login,
        queryParameters: {'from': state.uri.toString()},
      ).toString();
    }
    return null;
  }

  if (!user.emailVerified) {
    return location == RoutePaths.verifyEmail ? null : RoutePaths.verifyEmail;
  }

  if (location.startsWith(RoutePaths.authPrefix)) {
    final from = state.uri.queryParameters['from'];
    return (from != null && from.startsWith('/')) ? from : RoutePaths.home;
  }
  return null;
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = _AuthRefresh();
  ref.listen(authUserProvider, (previous, next) => refresh.notify());

  final router = GoRouter(
    initialLocation: RoutePaths.home,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: refresh,
    redirect: (context, state) => _redirect(ref, state),
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
                builder: (context, state) => const AccountScreen(),
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
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.signup,
        name: RouteNames.signup,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: RoutePaths.verifyEmail,
        name: RouteNames.verifyEmail,
        builder: (context, state) => const VerifyEmailScreen(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
}