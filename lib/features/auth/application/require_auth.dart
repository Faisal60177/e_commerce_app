import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

extension RequireAuth on WidgetRef {
  Future<bool> ensureSignedIn(BuildContext context) async {
    if(read(currentUidProvider) != null) return true;
    final signedIn = await context.pushNamed<bool>(RouteNames.login);
    return signedIn ?? false;
  }
}