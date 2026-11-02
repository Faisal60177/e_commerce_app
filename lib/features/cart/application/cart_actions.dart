import 'dart:math' as math;

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/cart/application/cart_providers.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_actions.g.dart';

@Riverpod(keepAlive: true)
CartActions cartActions(Ref ref) => CartActions(ref);

class CartActions {
  CartActions(this._ref);
  final Ref _ref;
  CartRepository get _repository => _ref.read(cartRepositoryProvider);
  
  String get _uid {
    final uid = _ref.read(currentUidProvider);
    if(uid == null) throw const AuthFailure('Please sign in to use your cart.');
    return uid;
  }

  Future<CartAddResult> add(Product product, {int quantity = 1}) =>
      _repository.addItem(_uid, product, quantity: quantity);
  Future<void> setQuantity(CartItem item, int quantity) => _repository
      .setQuantity(_uid, item.productId, math.min(quantity, item.maxQuantity));

  Future<void> remove(int productId) =>
      _repository.removeItem(_uid, productId);
  Future<void> restore(CartItem item) => _repository.restoreItem(_uid, item);
  Future<void> clear() => _repository.clear(_uid);
}