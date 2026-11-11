import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_totals.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_item.dart';
import 'package:e_commerce_app/features/orders/domain/entities/payment_method.dart';

class NewOrder {
  const NewOrder._({
    required this.items,
    required this.address,
    required this.paymentMethod,
    required this.note,
    required this.totals,
});

  factory NewOrder.create({
    required List<CartItem> items,
    required Address address,
    required PaymentMethod paymentMethod,
    String note = '',
}) {
    return NewOrder._(
        items: [
          for(final item in items)
            OrderItem(productId: item.productId,
                title: item.title,
                price: item.price,
                discountPercentage: item.discountPercentage,
                thumbnail: item.thumbnail,
                quantity: item.quantity,
            ),
        ],
        address: address,
        paymentMethod: paymentMethod,
        note: note.trim(),
        totals: CartTotals.from(items),
    );
  }

  final List<OrderItem> items;
  final Address address;
  final PaymentMethod paymentMethod;
  final String note;
  final CartTotals totals;
}
