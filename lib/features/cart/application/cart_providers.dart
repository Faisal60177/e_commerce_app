import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/cart/data/firestore_cart_repository.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_providers.g.dart';

@Riverpod(keepAlive: true)
CartRepository cartRepository(Ref ref) {
  return FirestoreCartRepository(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
Stream<List<CartItem>> cartItems(Ref ref) {
  final uid = ref.watch(currentUidProvider);
  if(uid == null) return Stream.value(const <CartItem>[]);
  return ref.watch(cartRepositoryProvider).watchCart(uid);
}

@Riverpod(keepAlive: true)
int cartCount(Ref ref) {
  final items = ref.watch(cartItemsProvider).value ?? const <CartItem>[];
  return items.fold<int>(0, (sum,item) => sum + item.quantity);
}