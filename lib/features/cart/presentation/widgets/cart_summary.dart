import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_totals.dart';
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
        child: Padding(padding: const .fromLTRB(16, 16, 16, 12),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            if(totals.amountToFreeShipping > 0) ...[
              Text('Add ${Formatters.price(totals.amountToFreeShipping)} more '
                  'for free shipping',
              style: context.textTheme.bodySmall,
              ),
              const SizedBox(height: 6,),
              ClipRRect(
                borderRadius: .circular(4),
                child: LinearProgressIndicator(
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 12,),
            ],
            _SummaryRow(label: 'Subtotal',
                value: Formatters.price(totals.listSubtotal),
            ),
            if(totals.savings > 0)
              _SummaryRow(label: 'Discount', value: '-${Formatters.price(totals.savings)}',
              valueColor: AppColors.success,
              ),
            _SummaryRow(label: 'Shipping',
                value: totals.shipping == 0
            ? 'Free' : Formatters.price(totals.shipping),
            ),
            const Divider(height: 20,),
            _SummaryRow(label: 'Total',
                value: Formatters.price(totals.total),
            bold: true,
            ),
            const SizedBox(height: 12,),
            FilledButton(onPressed: onCheckout,
              child: Text(
                'Checkout · ${totals.itemCount} '
                    '${totals.itemCount == 1 ? 'item' : 'items'}',
              ),
            )
          ],
        ),)),
  );

}

}

class _SummaryRow extends StatelessWidget{
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.bold = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool bold;

@override
Widget build(BuildContext context) {
  final style = bold
      ? context.textTheme.titleMedium?.copyWith(fontWeight: .w800)
      : context.textTheme.bodyMedium;
  return Padding(padding: const .symmetric(vertical: 3),
  child: Row(
    children: [
      Expanded(child: Text(label, style: style,)),
      Text(value, style: style?.copyWith(color: valueColor),),
    ],
  ),);
  
}
}