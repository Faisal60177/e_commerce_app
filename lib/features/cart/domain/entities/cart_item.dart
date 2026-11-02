import 'package:e_commerce_app/core/utils/price_utils.dart';
import 'package:e_commerce_app/features/cart/domain/cart_constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
abstract class CartItem  with _$CartItem{
  const factory CartItem({
    required int productId,
    required String title,
    required double price,
    required int quantity,
    @Default(0.0) double discountPercentage,
    @Default('') String thumbnail,
    @Default(CartConstants.maxQuantityPerItem) int maxQuantity,

}) = _CartItem;

  const CartItem._();

  double get unitPrice => PriceUtils.applyDiscount(price, discountPercentage);
  double get lineTotal => PriceUtils.roundMoney(unitPrice * quantity);
  double get listTotal => PriceUtils.roundMoney(price * quantity);
}