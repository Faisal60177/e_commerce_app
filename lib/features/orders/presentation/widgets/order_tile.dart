import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/order_status_chip.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({required this.order, required this.onTap, super.key});

  final Order order;
  final VoidCallback onTap;

@override
Widget build(BuildContext context) {
  final colors = context.colors;
  final shown = order.items.take(3).toList();
  final extra = order.items.length - shown.length;

  return Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(padding: const .all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Expanded(child: Text(
                'Order #${order.number}',
                style: context.textTheme.titleSmall,
              )),
              OrderStatusChip(status: order.status),
            ],
          ),
          const SizedBox(height: 4,),
          Text(
            Formatters.dateTime(order.createdAt),
            style: context.textTheme.bodySmall?.copyWith(
              color: colors.outline,
            ),
          ),
          const SizedBox(height: 12,),
          Row(
            children: [
              for(final item in shown)
                Padding(padding: const .only(right: 8),
                child: ClipRRect(
                  borderRadius: .circular(8),
                  child: SizedBox.square(
                    dimension: 48,
                    child: ColoredBox(color: colors.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                    child: CachedNetworkImage(imageUrl: item.thumbnail,
                    fit: BoxFit.contain,
                    memCacheWidth: 150,
                    errorWidget: (context, url, error) => Icon(
                      Icons.image_not_supported_outlined,
                      size: 20,
                      color: colors.outline,
                    ),),),
                  ),
                ),),
              if(extra > 0)
                Text('+$extra', style: context.textTheme.bodyMedium,),
              const Spacer(),
              Column(
                crossAxisAlignment: .end,
                children: [
                  Text(
                    '${order.itemCount} '
                        '${order.itemCount == 1 ? 'item' : 'items'}',
                    style:  context.textTheme.bodySmall,
                  ),
                  Text(
                    Formatters.price(order.total),
                    style: context.textTheme.titleSmall?.copyWith(
                      fontWeight: .w800,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),),
    ),
  );


}


}