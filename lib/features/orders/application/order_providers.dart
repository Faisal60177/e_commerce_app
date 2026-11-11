import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/orders/data/firestore_order_repository.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order.dart';
import 'package:e_commerce_app/features/orders/domain/repositories/order_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'order_providers.g.dart';

@Riverpod(keepAlive: true)
OrderRepository orderRepository(Ref ref) {
  return FirestoreOrderRepository(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
Stream<List<Order>> orders(Ref ref){
  final uid = ref.watch(currentUidProvider);
  if(uid == null) return Stream.value(const <Order>[]);
  return ref.watch(orderRepositoryProvider).watchOrders(uid);
}

@Riverpod(keepAlive: true)
Stream<Order?> order(Ref ref, String id) {
  final uid = ref.watch(currentUidProvider);
  if(uid == null) return Stream.value(null);
  return ref.watch(orderRepositoryProvider).watchOrder(uid, id);
}