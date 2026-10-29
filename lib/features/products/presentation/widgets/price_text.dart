import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/core/utils/price_utils.dart';
import 'package:flutter/material.dart';


class PriceText extends StatelessWidget{

  const PriceText({
    required this.price,
    required this.discountPercentage,
    this.large = false,
    super.key,
});

  final double price;
  final double discountPercentage;
  final bool large;

@override
Widget build(BuildContext context) {
  final discounted = PriceUtils.applyDiscount(price, discountPercentage);
  final style = large ? context.textTheme.headlineSmall : context.textTheme.titleSmall;

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(Formatters.price(discounted),
        style: style?.copyWith(
          fontWeight: FontWeight.w800,
          color: context.colors.primary,
        ),
      ),
      if(discountPercentage > 0) ...[
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            Formatters.price(price),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colors.outline,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        )
      ]
    ],

  );


}
}