import 'package:e_commerce_app/core/utils/price_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PriceUtils', () {
    test('roundMoney rounds to cents', () {
      expect(PriceUtils.roundMoney(10.126), closeTo(10.13, 0.0001));
      expect(PriceUtils.roundMoney(10.1), closeTo(10.1, 0.0001));
    });

    test('applyDiscount applies the percentage and rounds', () {
      expect(PriceUtils.applyDiscount(9.99, 10.48), closeTo(8.94, 0.0001));
      expect(PriceUtils.applyDiscount(100, 25), closeTo(75, 0.0001));
    });

    test('applyDiscount with no discount keeps the price', () {
      expect(PriceUtils.applyDiscount(49.99, 0), closeTo(49.99, 0.0001));
    });
  });
}
