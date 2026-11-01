abstract final class RoutePaths {
  static const home = '/';
  static const categories = '/categories';
  static const cart = '/cart';
  static const wishlist = '/wishlist';
  static const account = '/account';

  static const search = '/search';
  static const productDetail = '/product/:id';
  static const categoryProducts = '/category/:slug';
  static const productList = '/list/:sort';

  static const login = '/auth/login';
  static const signup = '/auth/signup';
  static const verifyEmail = '/auth/verify-email';
  static const forgotPassword = '/auth/forgot-password';
  static const authPrefix = '/auth';
}

abstract final class RouteNames {
  static const home = 'home';
  static const categories = 'categories';
  static const cart = 'cart';
  static const wishlist = 'wishlist';
  static const account = 'account';

  static const search = 'search';
  static const productDetail = 'product-detail';
  static const categoryProducts = 'category-products';
  static const productList = 'product-list';

  static const login = 'login';
  static const signup = 'signup';
  static const verifyEmail = 'verify-email';
  static const forgotPassword = 'forgot-password';
}