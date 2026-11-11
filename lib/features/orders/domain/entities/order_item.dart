import 'package:e_commerce_app/core/utils/price_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item.freezed.dart';

@freezed
abstract class OrderItem  with _$OrderItem{
  const factory OrderItem({
    required int productId,
    required String title,
    required double price,
    required int quantity,
    @Default(0.0) double discountPercentage,
    @Default('') String thumbnail,
  }) = _OrderItem;

  const OrderItem._();
  double get unitPrice => PriceUtils.applyDiscount(price, discountPercentage);
  double get lineTotal => PriceUtils.roundMoney(unitPrice * quantity);
}