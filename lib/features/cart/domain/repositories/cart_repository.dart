import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';

typedef CartAddResult = ({ int quantity, bool limitReached});

abstract interface class CartRepository {
  Stream<List<CartItem>> watchCart(String uid);
  Future<CartAddResult> addItem(String uid, Product product, {int quantity = 1});
  Future <void> setQuantity(String uid, int productId, int quantity);
  Future <void> removeItem(String uid, int productId);
  Future<void> restoreItem(String uid, CartItem item);
  Future<void> clear(String uid);
}