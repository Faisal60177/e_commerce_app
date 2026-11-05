import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/firestore_paths.dart';
import 'package:e_commerce_app/core/error/firestore_guard.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/address/domain/repositories/address_repository.dart';

class FirestoreAddressRepository implements AddressRepository {
  FirestoreAddressRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _items(String uid) =>
      _db.collection(FirestorePaths.addresses(uid));

  @override
  Stream<List<Address>> watchAddresses(String uid) async* {
    try {
      await for (final snapshot
      in _items(uid).orderBy('createdAt').snapshots()) {
        final addresses = snapshot.docs.map(_fromDoc).toList();
        yield [
          ...addresses.where((a) => a.isDefault),
          ...addresses.where((a) => !a.isDefault),
        ];
      }
    } on FirebaseException catch (e) {
      throw mapFirestoreError(e);
    }
  }

  @override
  Future<void> save(String uid, Address address) {
    return guardFirestore(() async {
      final collection = _items(uid);
      final snapshot = await collection.get();
      final isNew = address.id.isEmpty;
      final others = snapshot.docs.where((doc) => doc.id != address.id);

      final makeDefault = address.isDefault || others.isEmpty;
      final doc = isNew ? collection.doc() : collection.doc(address.id);

      final batch = _db.batch()
        ..set(
          doc,
          {
            'label': address.label.name,
            'fullName': address.fullName.trim(),
            'phone': address.phone.trim(),
            'line1': address.line1.trim(),
            'line2': address.line2.trim(),
            'city': address.city.trim(),
            'region': address.region.trim(),
            'postalCode': address.postalCode.trim(),
            'country': address.country.trim(),
            'isDefault': makeDefault,
            'updatedAt': FieldValue.serverTimestamp(),
            if (isNew) 'createdAt': FieldValue.serverTimestamp(),
          },
          SetOptions(merge: true),
        );

      if (makeDefault) {
        for (final other in others) {
          if (other.data()['isDefault'] == true) {
            batch.update(other.reference, {'isDefault': false});
          }
        }
      }
      await batch.commit();
    });
  }

  @override
  Future<void> delete(String uid, String addressId) {
    return guardFirestore(() async {
      final snapshot = await _items(uid).get();
      final target = snapshot.docs.where((doc) => doc.id == addressId);
      if (target.isEmpty) return;

      final wasDefault = target.first.data()['isDefault'] == true;
      final remaining = snapshot.docs.where((doc) => doc.id != addressId);

      final batch = _db.batch()..delete(target.first.reference);
      if (wasDefault && remaining.isNotEmpty) {
        batch.update(remaining.first.reference, {'isDefault': true});
      }
      await batch.commit();
    });
  }

  @override
  Future<void> setDefault(String uid, String addressId) {
    return guardFirestore(() async {
      final snapshot = await _items(uid).get();
      final batch = _db.batch();
      for (final doc in snapshot.docs) {
        batch.update(doc.reference, {'isDefault': doc.id == addressId});
      }
      await batch.commit();
    });
  }

  Address _fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    String text(String key) => data[key] as String? ?? '';

    return Address(
      id: doc.id,
      label: AddressLabel.fromName(data['label'] as String?),
      fullName: text('fullName'),
      phone: text('phone'),
      line1: text('line1'),
      line2: text('line2'),
      city: text('city'),
      region: text('region'),
      postalCode: text('postalCode'),
      country: text('country'),
      isDefault: data['isDefault'] == true,
    );
  }
}