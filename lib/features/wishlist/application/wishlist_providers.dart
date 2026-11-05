import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:e_commerce_app/features/wishlist/data/firestore_wishlist_repository.dart';
import 'package:e_commerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_providers.g.dart';

@Riverpod(keepAlive: true)
WishlistRepository wishlistRepository(Ref ref) {
  return FirestoreWishlistRepository(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
Stream<List<ProductSummary>> wishlistItems(Ref ref) {
  final uid = ref.watch(currentUidProvider);
  if(uid == null) return Stream.value(const<ProductSummary>[]);
  return ref.watch(wishlistRepositoryProvider).watchWishlist(uid);
}

@Riverpod(keepAlive: true)
Set<int> wishlistIds(Ref ref) {
  final items = ref.watch(wishlistItemsProvider).value ?? const <ProductSummary>[];
  return {for (final product in items) product.id};
}