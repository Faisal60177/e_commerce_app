import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/cart/application/cart_providers.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/orders/application/order_providers.dart';
import 'package:e_commerce_app/features/orders/domain/entities/new_order.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order.dart';
import 'package:e_commerce_app/features/orders/domain/entities/payment_method.dart';
import 'package:e_commerce_app/features/orders/domain/repositories/order_repository.dart';
import 'package:e_commerce_app/features/products/application/product_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_actions.g.dart';

@Riverpod(keepAlive: true)
OrderActions orderActions(Ref ref) => OrderActions(ref);

class OrderActions {
  OrderActions(this._ref);

  final Ref _ref;

  OrderRepository get _repository => _ref.read(orderRepositoryProvider);

  String get _uid {
    final uid = _ref.read(currentUidProvider);
    if (uid == null) throw const AuthFailure('Please sign in first.');
    return uid;
  }

  Future<String> placeOrder({
    required Address address,
    required PaymentMethod paymentMethod,
    String note = '',
  }) async {
    final uid = _uid;

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.every((result) => result == ConnectivityResult.none)) {
      throw const NetworkFailure();
    }

    final cartItems = _ref.read(cartItemsProvider).value ?? const <CartItem>[];
    if (cartItems.isEmpty) {
      throw const ValidationFailure('Your cart is empty.');
    }

    final verified = await _verify(cartItems);
    final draft = NewOrder.create(
      items: verified,
      address: address,
      paymentMethod: paymentMethod,
      note: note,
    );
    return _repository.placeOrder(uid, draft);
  }

  Future<void> cancel(String orderId) => _repository.cancelOrder(_uid, orderId);

  Future<void> advance(Order order) async {
    final next = order.status.next;
    if (next == null) return;
    await _repository.updateStatus(_uid, order.id, next);
  }

  Future<List<CartItem>> _verify(List<CartItem> items) async {
    final products = _ref.read(productRepositoryProvider);
    final fresh = await Future.wait(
      items.map((item) => products.getProductById(item.productId)),
    );

    final result = <CartItem>[];
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      final product = fresh[i];

      if (!product.isInStock) {
        throw ValidationFailure(
          '"${product.title}" is out of stock. Please remove it from your cart.',
        );
      }
      if (item.quantity > product.stock) {
        throw ValidationFailure(
          'Only ${product.stock} of "${product.title}" left. '
              'Please update your cart.',
        );
      }

      result.add(
        item.copyWith(
          title: product.title,
          price: product.price,
          discountPercentage: product.discountPercentage,
          thumbnail: product.thumbnail,
        ),
      );
    }
    return result;
  }
}