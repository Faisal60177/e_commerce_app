import 'dart:math' as math;
import 'package:e_commerce_app/core/utils/price_utils.dart';
import 'package:e_commerce_app/features/cart/domain/cart_constants.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';

class CartTotals {
  const CartTotals._({
    required this.itemCount,
    required this.listSubtotal,
    required this.itemsTotal,
    required this.shipping,
});

  factory CartTotals.from(List<CartItem> items) {
    var count =0;
    var list =0.0;
    var discounted = 0.0;
    for(final item in items) {
      count += item.quantity;
      list += item.listTotal;
      discounted += item.lineTotal;
    }
    final itemsTotal = PriceUtils.roundMoney(discounted);
    final shipping =
        items.isEmpty || itemsTotal >= CartConstants.freeShippingThreshold
    ? 0.0
            : CartConstants.flatShippingFee;

    return CartTotals._(
      itemCount: count,
      listSubtotal: PriceUtils.roundMoney(list),
      itemsTotal: itemsTotal,
      shipping: shipping,

    );
  }

  final int itemCount;
  final double listSubtotal;
  final double itemsTotal;
  final double shipping;
  bool get isEmpty => itemCount == 0;
  double get savings => PriceUtils.roundMoney(listSubtotal - itemsTotal);
  double get total => PriceUtils.roundMoney(itemsTotal + shipping);
  double get amountToFreeShipping => isEmpty ? 0
      : math.max(0, PriceUtils.roundMoney(CartConstants.freeShippingThreshold - itemsTotal,
  ),
  );
  double get freeShippingProgress =>
      math.min(1.0, itemsTotal / CartConstants.freeShippingThreshold);
}