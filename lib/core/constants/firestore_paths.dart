abstract final class FirestorePaths {
  static const users = 'users';

  static String user(String uid) => 'users/$uid';
  static String cart(String uid) => 'users/$uid/cart';
  static String whishlist(String uid) => 'users/$uid/wishlist';
  static String addressess(String uid) => 'users/$uid/addresses';
  static String orders(String uid) => 'users/$uid/orders';

}