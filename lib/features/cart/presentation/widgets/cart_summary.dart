import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_totals.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/price_breakdown.dart';
import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({
    required this.totals,
    required this.onCheckout,
    super.key,
  });

  final CartTotals totals;
  final VoidCallback onCheckout;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: context.colors.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (totals.amountToFreeShipping > 0) ...[
                Text(
                  'Add ${Formatters.price(totals.amountToFreeShipping)} more '
                      'for free shipping',
                  style: context.textTheme.bodySmall,
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: totals.freeShippingProgress,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              PriceBreakdown(
                subtotal: totals.listSubtotal,
                discount: totals.savings,
                shipping: totals.shipping,
                total: totals.total,
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: onCheckout,
                child: Text(
                  'Checkout · ${totals.itemCount} '
                      '${totals.itemCount == 1 ? 'item' : 'items'}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}