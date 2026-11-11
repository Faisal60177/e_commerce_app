import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_status.dart';
import 'package:e_commerce_app/features/orders/presentation/order_status_style.dart';
import 'package:flutter/material.dart';

class OrderStatusChip extends StatelessWidget{
  const OrderStatusChip({required this.status, super.key});

  final OrderStatus status;
  @override
  Widget build(BuildContext context) {
    final color = status.color(context);
    return DecoratedBox(decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: .circular(20),
    ),
      child: Padding(padding: const.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisSize: .min,
        children: [
          Icon(status.icon, size: 14,color: color,),
          const SizedBox(width: 4,),
          Text(
            status.label,
            style: context.textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: .w700,
            ),
          )
        ],
      ),),
    );
  }
}