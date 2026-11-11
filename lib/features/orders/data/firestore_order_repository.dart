import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:e_commerce_app/core/constants/firestore_paths.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/error/firestore_guard.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/orders/domain/entities/new_order.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_item.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_status.dart';
import 'package:e_commerce_app/features/orders/domain/entities/payment_method.dart';
import 'package:e_commerce_app/features/orders/domain/repositories/order_repository.dart';

class FirestoreOrderRepository implements OrderRepository {
  FirestoreOrderRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> _orders(String uid) =>
      _db.collection(FirestorePaths.orders(uid));

  @override
  Stream<List<Order>> watchOrders(String uid) async* {
    try {
      await for (final snapshot
      in _orders(uid).orderBy('createdAt', descending: true).snapshots()) {
        yield snapshot.docs
            .map((doc) => _fromData(doc.id, doc.data()))
            .whereType<Order>()
            .toList();
      }
    } on FirebaseException catch (e) {
      throw mapFirestoreError(e);
    }
  }

  @override
  Stream<Order?> watchOrder(String uid, String orderId) async* {
    try {
      await for (final doc in _orders(uid).doc(orderId).snapshots()) {
        final data = doc.data();
        yield data == null ? null : _fromData(doc.id, data);
      }
    } on FirebaseException catch (e) {
      throw mapFirestoreError(e);
    }
  }

  @override
  Future<String> placeOrder(String uid, NewOrder order) {
    return guardFirestore(() async {
      final orderRef = _orders(uid).doc();
      final cart = await _db.collection(FirestorePaths.cart(uid)).get();

      final batch = _db.batch()..set(orderRef, _toMap(order));
      for (final doc in cart.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();

      return orderRef.id;
    });
  }

  @override
  Future<void> cancelOrder(String uid, String orderId) {
    return guardFirestore(() {
      final ref = _orders(uid).doc(orderId);

      return _db.runTransaction<void>((transaction) async {
        final snapshot = await transaction.get(ref);
        if (!snapshot.exists) throw const NotFoundFailure();

        final status =
        OrderStatus.fromName(snapshot.data()?['status'] as String?);
        if (!status.canCancel) {
          throw const ValidationFailure('This order can no longer be cancelled.');
        }

        transaction.update(ref, {
          'status': OrderStatus.cancelled.name,
          'timeline.${OrderStatus.cancelled.name}': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });
    });
  }

  @override
  Future<void> updateStatus(String uid, String orderId, OrderStatus status) {
    return guardFirestore(() {
      return _orders(uid).doc(orderId).update({
        'status': status.name,
        'timeline.${status.name}': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  Map<String, dynamic> _toMap(NewOrder order) {
    final address = order.address;
    final totals = order.totals;

    return {
      'status': OrderStatus.pending.name,
      'paymentMethod': order.paymentMethod.name,
      'items': [
        for (final item in order.items)
          {
            'productId': item.productId,
            'title': item.title,
            'price': item.price,
            'discountPercentage': item.discountPercentage,
            'thumbnail': item.thumbnail,
            'quantity': item.quantity,
          },
      ],
      'address': {
        'label': address.label.name,
        'fullName': address.fullName.trim(),
        'phone': address.phone.trim(),
        'line1': address.line1.trim(),
        'line2': address.line2.trim(),
        'city': address.city.trim(),
        'region': address.region.trim(),
        'postalCode': address.postalCode.trim(),
        'country': address.country.trim(),
      },
      'itemCount': totals.itemCount,
      'listSubtotal': totals.listSubtotal,
      'itemsTotal': totals.itemsTotal,
      'shipping': totals.shipping,
      'total': totals.total,
      'note': order.note,
      'timeline': {OrderStatus.pending.name: FieldValue.serverTimestamp()},
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  Order? _fromData(String id, Map<String, dynamic> data) {
    final rawItems = data['items'];
    final rawAddress = data['address'];
    if (rawItems is! List || rawAddress is! Map<String, dynamic>) return null;

    final items = rawItems.whereType<Map<String, dynamic>>().map((map) {
      return OrderItem(
        productId: (map['productId'] as num?)?.toInt() ?? 0,
        title: map['title'] as String? ?? '',
        price: (map['price'] as num?)?.toDouble() ?? 0,
        discountPercentage: (map['discountPercentage'] as num?)?.toDouble() ?? 0,
        thumbnail: map['thumbnail'] as String? ?? '',
        quantity: (map['quantity'] as num?)?.toInt() ?? 1,
      );
    }).toList();

    String text(String key) => rawAddress[key] as String? ?? '';
    final address = Address(
      label: AddressLabel.fromName(rawAddress['label'] as String?),
      fullName: text('fullName'),
      phone: text('phone'),
      line1: text('line1'),
      line2: text('line2'),
      city: text('city'),
      region: text('region'),
      postalCode: text('postalCode'),
      country: text('country'),
    );

    double money(String key) => (data[key] as num?)?.toDouble() ?? 0;

    final timeline = <OrderStatus, DateTime>{};
    final rawTimeline = data['timeline'];
    if (rawTimeline is Map<String, dynamic>) {
      for (final entry in rawTimeline.entries) {
        final status = OrderStatus.tryParse(entry.key);
        final value = entry.value;
        if (status != null && value is Timestamp) {
          timeline[status] = value.toDate();
        }
      }
    }

    return Order(
      id: id,
      status: OrderStatus.fromName(data['status'] as String?),
      items: items,
      address: address,
      paymentMethod: PaymentMethod.fromName(data['paymentMethod'] as String?),
      listSubtotal: money('listSubtotal'),
      itemsTotal: money('itemsTotal'),
      shipping: money('shipping'),
      total: money('total'),
      // Null only for a moment while the server timestamp is pending.
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      timeline: timeline,
      note: data['note'] as String? ?? '',
    );
  }
}