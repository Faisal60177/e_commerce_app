import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/app/shell/main_shell.dart';
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
import 'package:e_commerce_app/features/address/presentation/screens/address_form_screen.dart';
import 'package:e_commerce_app/features/address/presentation/screens/addresses_screen.dart';
import 'package:e_commerce_app/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:e_commerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:e_commerce_app/features/checkout/presentation/screens/checkout_screen.dart';
import 'package:e_commerce_app/features/orders/presentation/screens/order_detail_screen.dart';
import 'package:e_commerce_app/features/orders/presentation/screens/order_success_screen.dart';
import 'package:e_commerce_app/features/orders/presentation/screens/orders_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/screens/change_password_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:e_commerce_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:e_commerce_app/app/router/safe_redirect.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/splash_screen.dart';

part 'app_router.g.dart';

const _protectedPrefixes = [
  '/checkout',
  '/orders',
  '/order-success',
  '/addresses',
  '/profile',
];

class _AuthRefresh extends ChangeNotifier {
  void notify() => notifyListeners();
}

bool _isProtected(String location) =>
    _protectedPrefixes.any((p) => location == p || location.startsWith('$p/'));

String? _redirect(Ref ref, GoRouterState state) {
  final status = ref.read(authStatusProvider);
  final location = state.matchedLocation;
  final onSplash = location == RoutePaths.splash;
  final onVerify = location == RoutePaths.verifyEmail;
  final from = safeRedirectPath(state.uri.queryParameters['from']);

  switch (status) {
    case AuthStatus.unknown:
      if (onSplash) return null;
      return Uri(
        path: RoutePaths.splash,
        queryParameters: {'from': state.uri.toString()},
      ).toString();

    case AuthStatus.signedOut:
      if (onSplash) return from ?? RoutePaths.home;
      if (onVerify) return RoutePaths.login;
      if (_isProtected(location)) {
        return Uri(
          path: RoutePaths.login,
          queryParameters: {'from': state.uri.toString()},
        ).toString();
      }
      return null;

    case AuthStatus.needsVerification:
      return onVerify ? null : RoutePaths.verifyEmail;

    case AuthStatus.signedIn:
      if (onSplash) return from ?? RoutePaths.home;
      if (onVerify) return RoutePaths.home;
      return null;
  }
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final refresh = _AuthRefresh();
  ref.listen(authStatusProvider, (previous, next) => refresh.notify());

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
                builder: (context, state) => const CartScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.wishlist,
                name: RouteNames.wishlist,
                builder: (context, state) => const WishlistScreen(),
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
        builder: (context, state) =>
            LoginScreen(redirectTo: state.uri.queryParameters['from']),
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

      GoRoute(
        path: RoutePaths.addresses,
        name: RouteNames.addresses,
        builder: (context, state) => const AddressesScreen(),
      ),
      GoRoute(
        path: RoutePaths.addAddress,
        name: RouteNames.addAddress,
        builder: (context, state) => const AddressFormScreen(),
      ),
      GoRoute(
        path: RoutePaths.editAddress,
        name: RouteNames.editAddress,
        builder: (context, state) =>
            AddressFormScreen(addressId: state.pathParameters['id']),
      ),

      GoRoute(
        path: RoutePaths.checkout,
        name: RouteNames.checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: RoutePaths.orders,
        name: RouteNames.orders,
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: RoutePaths.orderDetail,
        name: RouteNames.orderDetail,
        builder: (context, state) =>
            OrderDetailScreen(orderId: state.pathParameters['id'] ?? ''),
      ),
      GoRoute(
        path: RoutePaths.orderSuccess,
        name: RouteNames.orderSuccess,
        builder: (context, state) =>
            OrderSuccessScreen(orderId: state.pathParameters['id'] ?? ''),
      ),
      GoRoute(
        path: RoutePaths.editProfile,
        name: RouteNames.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: RoutePaths.changePassword,
        name: RouteNames.changePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.settings,
        name: RouteNames.settings,
        builder: (context, state) => const SettingsScreen(),
      ),

      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    refresh.dispose();
  });
  return router;
}
