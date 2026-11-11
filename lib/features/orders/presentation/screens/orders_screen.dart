import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/widgets/app_empty_view.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:e_commerce_app/features/orders/application/order_providers.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My orders')),
      body: orders.when(
        loading: () => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
          const ShimmerBox(height: 140, radius: 16),
        ),
        error: (error, stackTrace) => AppErrorView(
          message: failureMessage(error),
          onRetry: () => ref.invalidate(ordersProvider),
        ),
        data: (items) => items.isEmpty
            ? AppEmptyView(
          icon: Icons.receipt_long_outlined,
          title: 'No orders yet',
          subtitle: 'Your orders will appear here after checkout.',
          actionLabel: 'Start shopping',
          onAction: () => context.goNamed(RouteNames.home),
        )
            : ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final order = items[index];
            return OrderTile(
              order: order,
              onTap: () => context.pushNamed(
                RouteNames.orderDetail,
                pathParameters: {'id': order.id},
              ),
            );
          },
        ),
      ),
    );
  }
}