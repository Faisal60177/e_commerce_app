import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order_status.dart';
import 'package:flutter/material.dart';

extension OrderStatusStyle on OrderStatus{
  IconData get icon => switch (this) {
    OrderStatus.pending => Icons.receipt_long_outlined,
    OrderStatus.confirmed => Icons.check_circle_outline_rounded,
    OrderStatus.shipped => Icons.local_shipping_outlined,
    OrderStatus.delivered => Icons.inventory_2_outlined,
    OrderStatus.cancelled => Icons.cancel_outlined,

  };

  Color color(BuildContext context) => switch (this) {
    OrderStatus.pending => AppColors.warning,
    OrderStatus.confirmed => context.colors.primary,
    OrderStatus.shipped => context.colors.tertiary,
    OrderStatus.delivered => AppColors.success,
    OrderStatus.cancelled => context.colors.error,

  };
}