import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/firestore_paths.dart';
import 'package:e_commerce_app/core/error/firestore_guard.dart';
import 'package:e_commerce_app/features/products/domain/entities/product_summary.dart';
import 'package:e_commerce_app/features/wishlist/domain/repositories/wishlist_repository.dart';

class FirestoreWishlistRepository implements WishlistRepository {
  FirestoreWishlistRepository(this._db);

  final FirebaseFirestore _db;
  CollectionReference<Map<String,dynamic>> _items(String uid) =>
      _db.collection(FirestorePaths.wishlist(uid));

  @override
  Stream<List<ProductSummary>> watchWishlist(String uid) async*{
    try {
      await for(final snapshot
      in _items(uid).orderBy('addedAt', descending: true).snapshots()) {
        yield snapshot.docs.map(_fromDoc).whereType<ProductSummary>().toList();
      }
    } on FirebaseException catch(e) {
      throw mapFirestoreError(e);
    }
  }

  @override
  Future<void> add(String uid, ProductSummary product) {
    return guardFirestore(() {
      return _items(uid).doc('${product.id}').set({
        'productId' :product.id,
        'title': product.title,
        'price': product.price,
        'thumbnail': product.thumbnail,
        'rating': product.rating,
        'discountPercentage': product.discountPercentage,
        'addedAt' : FieldValue.serverTimestamp(),
      });

    });
  }

  @override
  Future<void> remove(String uid, int productId) {
    return guardFirestore(() => _items(uid).doc('$productId').delete());
  }

  ProductSummary? _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    final id = (data['productId'] as num?)?.toInt();
    final title = data['title'];
    final price = (data['price'] as num?)?.toDouble();
    if(id == null || title is! String || price == null) return null;

    return ProductSummary(id: id, title: title, price: price,
    thumbnail: data['thumbnail'] as String? ?? '',
    rating: (data['rating'] as num?)?.toDouble() ?? 0,
    discountPercentage: (data['discountPercentage']as num?)?.toDouble() ?? 0,);
  }
}