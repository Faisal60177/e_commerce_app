import 'package:e_commerce_app/app/router/navigation_extensions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/core/widgets/app_empty_view.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/core/widgets/line_item_row.dart';
import 'package:e_commerce_app/core/widgets/section_card.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/address_summary.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/price_breakdown.dart';
import 'package:e_commerce_app/features/orders/application/order_actions.dart';
import 'package:e_commerce_app/features/orders/application/order_providers.dart';
import 'package:e_commerce_app/features/orders/domain/entities/order.dart';
import 'package:e_commerce_app/features/orders/domain/order_constants.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/order_status_chip.dart';
import 'package:e_commerce_app/features/orders/presentation/widgets/order_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({required this.orderId, super.key});

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderProvider(orderId));
    final loaded = state.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(loaded == null ? 'Order' : 'Order #${loaded.number}'),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => AppErrorView(
          message: failureMessage(error),
          onRetry: () => ref.invalidate(orderProvider(orderId)),
        ),
        data: (order) => order == null
            ? const AppEmptyView(
          icon: Icons.receipt_long_outlined,
          title: 'Order not found',
        )
            : _OrderBody(order: order),
      ),
    );
  }
}

class _OrderBody extends ConsumerStatefulWidget {
  const _OrderBody({required this.order});

  final Order order;

  @override
  ConsumerState<_OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends ConsumerState<_OrderBody> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action, {String? success}) async {
    setState(() => _busy = true);
    try {
      await action();
      if (mounted && success != null) context.showSnack(success);
    } on Failure catch (failure) {
      if (mounted) context.showSnack(failure.message, isError: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _cancel() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel this order?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep order'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cancel order'),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false)) return;

    await _run(
          () => ref.read(orderActionsProvider).cancel(widget.order.id),
      success: 'Order cancelled',
    );
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final colors = context.colors;
    final next = order.status.next;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            OrderStatusChip(status: order.status),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Placed ${Formatters.dateTime(order.createdAt)}',
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SectionCard(title: 'Order tracking', child: OrderTimeline(order: order)),
        const SizedBox(height: 20),
        SectionCard(
          title: 'Items (${order.itemCount})',
          child: Column(
            children: [
              for (var i = 0; i < order.items.length; i++) ...[
                if (i > 0) const Divider(height: 8),
                LineItemRow(
                  title: order.items[i].title,
                  thumbnail: order.items[i].thumbnail,
                  unitPrice: order.items[i].unitPrice,
                  quantity: order.items[i].quantity,
                  lineTotal: order.items[i].lineTotal,
                  onTap: () => context.openProduct(order.items[i].productId),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        SectionCard(
          title: 'Delivery address',
          child: AddressSummary(address: order.address),
        ),
        const SizedBox(height: 20),
        SectionCard(
          title: 'Payment',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.payments_outlined, color: colors.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      order.paymentMethod.title,
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              if (order.note.isNotEmpty) ...[
                const Divider(height: 24),
                Text('Note', style: context.textTheme.labelMedium),
                const SizedBox(height: 4),
                Text(order.note, style: context.textTheme.bodyMedium),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        SectionCard(
          title: 'Order summary',
          child: PriceBreakdown(
            subtotal: order.listSubtotal,
            discount: order.savings,
            shipping: order.shipping,
            total: order.total,
          ),
        ),
        if (order.status.canCancel) ...[
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: _busy ? null : _cancel,
            style: OutlinedButton.styleFrom(foregroundColor: colors.error),
            icon: const Icon(Icons.cancel_outlined),
            label: const Text('Cancel order'),
          ),
        ],
        if (OrderConstants.demoStatusControls && next != null) ...[
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: _busy
                ? null
                : () => _run(() => ref.read(orderActionsProvider).advance(order)),
            icon: const Icon(Icons.fast_forward_rounded),
            label: Text('Demo: mark as ${next.label}'),
          ),
          const SizedBox(height: 6),
          Text(
            'Demo control: simulates the store updating this order.',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(color: colors.outline),
          ),
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}