import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/app/shell/main_shell.dart';
import 'package:e_commerce_app/core/widgets/placeholder_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref){
  final router = GoRouter(
      initialLocation: RoutePaths.home,
      debugLogDiagnostics: kDebugMode,
      routes: [
        StatefulShellRoute.indexedStack(builder: (context, state, shell) => MainShell(navigationShell: shell),
            branches: [
              StatefulShellBranch(routes: [
                GoRoute(path: RoutePaths.home,
                name: RouteNames.home,
                  builder: (context,state) =>
                      const PlaceholderScreen(title: 'Home'),
                ),
              ],
              ),

              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: RoutePaths.categories,
                    name: RouteNames.categories,
                    builder: (context, state) =>
                    const PlaceholderScreen(title: 'Categories'),
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

      ],
  );

  ref.onDispose(router.dispose);
  return router;
}