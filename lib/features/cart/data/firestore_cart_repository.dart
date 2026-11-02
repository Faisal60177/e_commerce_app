import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/firestore_paths.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/error/firestore_guard.dart';
import 'package:e_commerce_app/features/cart/domain/cart_constants.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';

class FirestoreCartRepository implements CartRepository {
  FirestoreCartRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _items(String uid) =>
      _db.collection(FirestorePaths.cart(uid));

  @override
  Stream<List<CartItem>> watchCart(String uid) async* {
    try {
      await for (final snapshot in _items(uid).orderBy('addedAt').snapshots()) {
        yield snapshot.docs.map(_fromDoc).whereType<CartItem>().toList();
      }
    } on FirebaseException catch (e) {
      throw mapFirestoreError(e);
    }
  }

  @override
  Future<CartAddResult> addItem(
      String uid,
      Product product, {
        int quantity = 1,
      }) {
    final max = math.min(product.stock, CartConstants.maxQuantityPerItem);
    if (max < 1) {
      throw const DatabaseFailure('This item is out of stock.');
    }

    return guardFirestore(() {
      final doc = _items(uid).doc('${product.id}');

      return _db.runTransaction<CartAddResult>((transaction) async {
        final snapshot = await transaction.get(doc);
        final existing =
            (snapshot.data()?['quantity'] as num?)?.toInt() ?? 0;
        final requested = existing + quantity;
        final finalQuantity = math.min(math.max(requested, 1), max);

        final details = <String, dynamic>{
          'productId': product.id,
          'title': product.title,
          'price': product.price,
          'discountPercentage': product.discountPercentage,
          'thumbnail': product.thumbnail,
          'maxQuantity': max,
          'quantity': finalQuantity,
          'updatedAt': FieldValue.serverTimestamp(),
        };

        if (snapshot.exists) {
          transaction.update(doc, details);
        } else {
          transaction.set(doc, {
            ...details,
            'addedAt': FieldValue.serverTimestamp(),
          });
        }

        return (quantity: finalQuantity, limitReached: requested > max);
      });
    });
  }

  @override
  Future<void> setQuantity(String uid, int productId, int quantity) {
    return guardFirestore(() async {
      final doc = _items(uid).doc('$productId');
      if (quantity < 1) {
        await doc.delete();
        return;
      }
      await doc.update({
        'quantity': math.min(quantity, CartConstants.maxQuantityPerItem),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> removeItem(String uid, int productId) {
    return guardFirestore(() => _items(uid).doc('$productId').delete());
  }

  @override
  Future<void> restoreItem(String uid, CartItem item) {
    return guardFirestore(() {
      return _items(uid).doc('${item.productId}').set({
        'productId': item.productId,
        'title': item.title,
        'price': item.price,
        'discountPercentage': item.discountPercentage,
        'thumbnail': item.thumbnail,
        'maxQuantity': item.maxQuantity,
        'quantity': item.quantity,
        'addedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  @override
  Future<void> clear(String uid) {
    return guardFirestore(() async {
      final snapshot = await _items(uid).get();
      final batch = _db.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    });
  }

  CartItem? _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final id = (data['productId'] as num?)?.toInt();
    final title = data['title'];
    final price = (data['price'] as num?)?.toDouble();
    final quantity = (data['quantity'] as num?)?.toInt();

    if (id == null || title is! String || price == null || quantity == null) {
      return null;
    }

    return CartItem(
      productId: id,
      title: title,
      price: price,
      quantity: quantity,
      discountPercentage: (data['discountPercentage'] as num?)?.toDouble() ?? 0,
      thumbnail: data['thumbnail'] as String? ?? '',
      maxQuantity: (data['maxQuantity'] as num?)?.toInt() ??
          CartConstants.maxQuantityPerItem,
    );
  }
}