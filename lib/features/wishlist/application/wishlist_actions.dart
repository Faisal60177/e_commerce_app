import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:e_commerce_app/features/wishlist/application/wishlist_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_actions.g.dart';

@Riverpod(keepAlive: true)
WishlistActions wishlistActions(Ref ref) => WishlistActions(ref);

class WishlistActions {
  WishlistActions(this._ref);
  
  final Ref _ref;
  String get _uid {
    final uid = _ref.read(currentUidProvider);
    if(uid == null) {
      throw const AuthFailure('Please sign in to use your wishlist.');
    }
    return uid;
  }

  Future<bool> toggle(ProductSummary product) async {
    final repository = _ref.read(wishlistRepositoryProvider);
    final saved = _ref.read(wishlistIdsProvider).contains(product.id);

    if(saved) {
      await repository.remove(_uid, product.id);
      return false;
    }
    await repository.add(_uid, product);
    return true;
  }
  Future<void> remove(int productId) =>
      _ref.read(wishlistRepositoryProvider).remove(_uid, productId);
}