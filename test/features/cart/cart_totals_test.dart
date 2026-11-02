import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_totals.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CartItem', () {
    test('rounds unit price and line total to cents', () {
      const item = CartItem(
        productId: 1,
        title: 'Mascara',
        price: 9.99,
        discountPercentage: 10.48,
        quantity: 3,
      );

      expect(item.unitPrice, closeTo(8.94, 0.001));
      expect(item.lineTotal, closeTo(26.82, 0.001));
      expect(item.listTotal, closeTo(29.97, 0.001));
    });
  });

  group('CartTotals', () {
    test('empty cart has no shipping and no total', () {
      final totals = CartTotals.from(const []);

      expect(totals.isEmpty, isTrue);
      expect(totals.shipping, 0);
      expect(totals.total, 0);
      expect(totals.amountToFreeShipping, 0);
    });

    test('charges flat shipping under the free-shipping threshold', () {
      final totals = CartTotals.from(const [
        CartItem(productId: 1, title: 'A', price: 20, quantity: 2),
      ]);

      expect(totals.itemsTotal, 40);
      expect(totals.shipping, closeTo(4.99, 0.001));
      expect(totals.total, closeTo(44.99, 0.001));
      expect(totals.amountToFreeShipping, closeTo(60, 0.001));
    });

    test('ships free at or above the threshold and reports savings', () {
      final totals = CartTotals.from(const [
        CartItem(
          productId: 2,
          title: 'B',
          price: 100,
          discountPercentage: 10,
          quantity: 2,
        ),
      ]);

      expect(totals.listSubtotal, 200);
      expect(totals.itemsTotal, 180);
      expect(totals.savings, 20);
      expect(totals.shipping, 0);
      expect(totals.total, 180);
      expect(totals.itemCount, 2);
    });
  });
}