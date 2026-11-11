import 'package:e_commerce_app/core/utils/price_utils.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_item.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_status.dart';
import 'package:e_commerce_app/features/orders/domain/entities/payment_method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';

@freezed
abstract class Order with _$Order {
  const factory Order({
    required String id,
    required OrderStatus status,
    required List<OrderItem> items,
    required Address address,
    required PaymentMethod paymentMethod,
    required double listSubtotal,
    required double itemsTotal,
    required double shipping,
    required double total,
    required DateTime createdAt,
    @Default({}) Map<OrderStatus, DateTime> timeline,
    @Default('') String note,
}) = _Order;

  const Order._();

  String get number =>
      (id.length < 8 ? id : id.substring(0, 8)).toUpperCase();
  int get  itemCount => items.fold(0, (add, item) => add + item.quantity);
  double get savings => PriceUtils.roundMoney(listSubtotal - itemsTotal);

  DateTime? timeFor(OrderStatus status) =>
      timeline[status] ?? (status == OrderStatus.pending ? createdAt : null);


}