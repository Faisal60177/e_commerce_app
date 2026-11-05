import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';

abstract interface class WishlistRepository {
  Stream<List<ProductSummary>> watchWishlist(String uid);
  Future<void> add (String uid, ProductSummary product) ;
  Future <void> remove(String uid, int productId);

}