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

  static const addresses = '/addresses';
  static const addAddress = '/addresses/new';
  static const editAddress = '/addresses/:id/edit';

  static const checkout = '/checkout';
  static const orders = '/orders';
  static const orderDetail = '/orders/:id';
  static const orderSuccess = '/order-success/:id';

  static const editProfile = '/profile/edit';
  static const changePassword = '/profile/change-password';
  static const settings = '/settings';
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

  static const addresses = 'addresses';
  static const addAddress = 'add-address';
  static const editAddress = 'edit-address';

  static const checkout = 'checkout';
  static const orders = 'orders';
  static const orderDetail = 'order-detail';
  static const orderSuccess = 'order-success';

  static const editProfile = 'edit-profile';
  static const changePassword = 'change-password';
  static const settings = 'settings';
}