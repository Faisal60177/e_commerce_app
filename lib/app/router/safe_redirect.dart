import 'package:e_commerce_app/app/router/route_names.dart';

String? safeRedirectPath(String? path) {
  if (path == null || path.isEmpty) return null;
  if (!path.startsWith('/') || path.startsWith('//')) return null;
  if (path == RoutePaths.authPrefix ||
      path.startsWith('${RoutePaths.authPrefix}/')) {
    return null;
  }
  if (path.startsWith(RoutePaths.splash)) return null;
  return path;
}
