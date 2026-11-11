import 'package:e_commerce_app/app/theme/app_colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:flutter/material.dart';

class PriceBreakdown extends StatelessWidget{
  const PriceBreakdown({
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.total,
    super.key,
  });

  final double subtotal;
  final double discount;
  final double shipping;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      children: [
        _Row(label: 'Subtotal', value: Formatters.price(subtotal)),
        if(discount > 0)
          _Row(label: 'Discount',
            value: '-${Formatters.price(discount)}',
            valueColor: AppColors.success,
          ),
        _Row(label: 'Shipping', value: shipping == 0 ? 'Free' : Formatters.price(shipping),
        ),
        const Divider(height: 20,),
        _Row(label: 'Total', value: Formatters.price(total), bold: true,),
      ],
    );
  }
}

class _Row extends StatelessWidget{
  const _Row({
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
    child:  Row(
      children: [
        Expanded(child: Text(label, style: style,)),
        Text(value, style: style?.copyWith(color: valueColor),),
      ],
    ),);

  }
}