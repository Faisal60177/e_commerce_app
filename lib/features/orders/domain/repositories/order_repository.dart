import 'package:e_commerce_app/features/orders/domain/entities/new_order.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_status.dart';

abstract interface class OrderRepository {
  Stream<List<Order>> watchOrders(String uid);
  Stream<Order?> watchOrder(String uid, String orderId);
  Future<String> placeOrder(String uid, NewOrder order);
  Future<void> cancelOrder(String uid, String orderId);
  Future<void> updateStatus(String uid, String orderId, OrderStatus status);
}