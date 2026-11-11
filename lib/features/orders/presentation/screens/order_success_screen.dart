import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/orders/application/order_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrderSuccessScreen extends ConsumerWidget {
  const OrderSuccessScreen({required this.orderId, super.key});

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(orderProvider(orderId)).value;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) context.goNamed(RouteNames.home);
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) =>
                          Transform.scale(scale: value, child: child),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        size: 104,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Order placed!',
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    order == null
                        ? 'Thank you for your order.'
                        : 'Thank you! Your order #${order.number} is on its way '
                        'to being confirmed.\n'
                        'Total ${Formatters.price(order.total)} · '
                        '${order.paymentMethod.title}',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colors.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: () => context.pushNamed(
                      RouteNames.orderDetail,
                      pathParameters: {'id': orderId},
                    ),
                    child: const Text('View order'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () => context.goNamed(RouteNames.home),
                    child: const Text('Continue shopping'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}