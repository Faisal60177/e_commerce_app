import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/firestore_paths.dart';
import 'package:e_commerce_app/core/error/firestore_guard.dart';
import 'package:e_commerce_app/features/profile/domain/entities/user_profile.dart';
import 'package:e_commerce_app/features/profile/domain/repositories/profile_repository.dart';

class FirestoreProfileRepository  implements ProfileRepository{
  FirestoreProfileRepository(this._db);

  final FirebaseFirestore _db;

  static const _batchSize = 400;
  DocumentReference<Map<String, dynamic>> _doc (String uid) =>
      _db.doc(FirestorePaths.user(uid));

  @override
  Stream<UserProfile> watchProfile(String uid) async* {
    try {
      await for(final snapshot in _doc(uid).snapshots()) {
        final data = snapshot.data();
        yield UserProfile(
          phone: data?['phone'] as String? ?? '',
          avatarIndex: (data?['avatarIndex'] as num?)?.toInt() ?? 0,
        );
      }
    } on FirebaseException catch(e) {
      throw mapFirestoreError(e);
    }
  }

  @override
  Future<void> saveProfile(String uid, UserProfile profile) {
    return guardFirestore(() {
      return _doc(uid).set(
        {
          'phone': profile.phone,
          'avatarIndex' : profile.avatarIndex,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    });
  }

  @override
  Future<void> deleteUserData(String uid) {
    return guardFirestore(() async {
      final collections = [
        FirestorePaths.cart(uid),
        FirestorePaths.wishlist(uid),
        FirestorePaths.addresses(uid),
        FirestorePaths.orders(uid),
      ];
      for(final path in collections) {
        await _deleteCollection(path);
      }
      await _doc(uid).delete();
    });
  }

  Future<void> _deleteCollection(String path) async {
    while(true) {
      final snapshot = await _db.collection(path).limit(_batchSize).get();
      if(snapshot.docs.isEmpty) return;

      final batch = _db.batch();
      for(final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }
}