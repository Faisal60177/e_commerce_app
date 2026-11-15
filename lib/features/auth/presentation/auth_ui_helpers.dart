import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/app/router/safe_redirect.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/auth/application/auth_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void leaveAuthFlow(BuildContext context, {String? redirectTo}) {
  final canPop = context.canPop();
  debugPrint('leaveAuthFlow canPop=$canPop redirectTo=$redirectTo');
  if (canPop) {
    context.pop(true);
  } else {
    context.go(safeRedirectPath(redirectTo) ?? RoutePaths.home);
  }
}

extension AuthErrorListener on WidgetRef {
  void listenAuthErrors(BuildContext context) {
    listen(authControllerProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        context.showSnack(failureMessage(next.error!), isError: true);
      }
    });
  }
}