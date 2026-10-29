abstract final class ApiConstants {

  static const baseUrl = 'https://dummyjson.com';
  static const product = '/products';
  static const productSearch = '/products/search';
  static const categories = '/products/categories';
  static String productById(int id) => '/products/$id';
  static String productByCategory(String slug) => '/products/category/$slug';

  static const summaryFields = 'title,price,thumbnail,rating,discountPercentage';

  static const defaultPageSize = 20;
  static const connectTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 20);

}