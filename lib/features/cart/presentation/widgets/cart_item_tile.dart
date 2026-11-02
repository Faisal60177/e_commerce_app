import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/quantity_stepper.dart';
import 'package:e_commerce_app/features/products/presentation/widgets/price_text.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {

const CartItemTile({
required this.item,
required this.onQuantityChanged,
required this.onRemove,
required this.onTap,
super.key,
});

final CartItem item;
final ValueChanged<int> onQuantityChanged;
final VoidCallback onRemove;
final VoidCallback onTap;

@override
Widget build(BuildContext context) {
  final colors = context.colors;

  return Dismissible(key: ValueKey('cart-${item.productId}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove,
      background: Container(
        alignment: .centerRight,
        padding:  const .only(right: 24),
        decoration: BoxDecoration(
          color: colors.errorContainer,
          borderRadius: .circular(16),
        ),
        child: Icon(Icons.delete_outline_rounded, color: colors.onErrorContainer,),
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: const .all(12),
          child: Row(
            crossAxisAlignment: .start,
            children: [
              ClipRRect(
                borderRadius: .circular(12),
                child: SizedBox.square(
                  dimension: 84,
                  child: ColoredBox(color: colors.surfaceContainerHighest.withValues(alpha: 0.5),
                  child: CachedNetworkImage(
                      imageUrl: item.thumbnail,
                  fit: BoxFit.contain,
                  memCacheWidth: 250,
                  errorWidget: (context, url, error) => Icon(
                    Icons.image_not_supported_outlined, color: colors.outline,
                  ),),),
                ),
              ),
              const SizedBox(width: 12,),
              Expanded(child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      Expanded(child: Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.titleSmall,
                      )),
                      IconButton(
                          tooltip: 'Remove',
                          onPressed: onRemove,
                          icon: const Icon(Icons.close_rounded, size: 20,),
                      visualDensity: .compact,
                      padding: .zero,
                      constraints: const BoxConstraints.tightFor(width: 32, height: 32,
                      ),)
                    ],
                  ),
                  PriceText(price: item.price,
                      discountPercentage: item.discountPercentage,
                  ),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      QuantityStepper(
                          quantity: item.quantity,
                          max: item.maxQuantity,
                          onChanged: onQuantityChanged,
                      ),
                      const Spacer(),
                      Text(Formatters.price(item.lineTotal),
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),),
                    ],
                  )
                ],
              ))
            ],
          ),),
        ),
      ));


}



}