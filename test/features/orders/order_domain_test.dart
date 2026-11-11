import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/orders/domain/entities/new_order.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_status.dart';
import 'package:e_commerce_app/features/orders/domain/entities/payment_method.dart';
import 'package:flutter_test/flutter_test.dart';

const _address = Address(
  fullName: 'Mohammad',
  phone: '+8801700000000',
  line1: 'House 1, Road 2',
  city: 'Chattogram',
  region: 'Chattogram',
  postalCode: '4000',
  country: 'Bangladesh',
);

void main() {
  group('NewOrder', () {
    test('snapshots items and computes totals', () {
      final order = NewOrder.create(
        items: const [
          CartItem(
            productId: 1,
            title: 'Phone',
            price: 100,
            discountPercentage: 10,
            quantity: 2,
            thumbnail: 'thumb',
          ),
        ],
        address: _address,
        paymentMethod: PaymentMethod.cashOnDelivery,
        note: '  Leave at the door  ',
      );

      expect(order.items.single.productId, 1);
      expect(order.items.single.lineTotal, 180);
      expect(order.totals.itemsTotal, 180);
      expect(order.totals.shipping, 0);
      expect(order.totals.total, 180);
      expect(order.note, 'Leave at the door');
    });
  });

  group('OrderStatus', () {
    test('follows the happy path and ends at delivered', () {
      expect(OrderStatus.pending.next, OrderStatus.confirmed);
      expect(OrderStatus.confirmed.next, OrderStatus.shipped);
      expect(OrderStatus.shipped.next, OrderStatus.delivered);
      expect(OrderStatus.delivered.next, isNull);
      expect(OrderStatus.cancelled.next, isNull);
    });

    test('only pending orders can be cancelled', () {
      expect(OrderStatus.pending.canCancel, isTrue);
      expect(OrderStatus.confirmed.canCancel, isFalse);
      expect(OrderStatus.delivered.isFinal, isTrue);
    });

    test('parses unknown names safely', () {
      expect(OrderStatus.tryParse('nonsense'), isNull);
      expect(OrderStatus.fromName('shipped'), OrderStatus.shipped);
      expect(OrderStatus.fromName(null), OrderStatus.pending);
    });
  });
}