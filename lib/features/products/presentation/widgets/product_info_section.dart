import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductInfoSection extends StatelessWidget {

  const ProductInfoSection({required this.product, super.key});

final Product product;

@override
Widget build(BuildContext context) {

  final dimensions = product.dimensions;

  final rows = <(IconData, String, String)>[
    if(product.shippingInformation != null)
      (Icons.local_shipping_outlined, 'Shipping', product.shippingInformation!),
    if(product.warrantyInformation != null)
      (Icons.verified_user_outlined, 'Warranty', product.warrantyInformation!),
    if(product.returnPolicy != null)
      (Icons.assignment_return_outlined, 'Returns', product.returnPolicy!),
    if(product.minimumOrderQuantity != null)
      (Icons.inventory_2_outlined, 'Minimum order', '${product.minimumOrderQuantity} pcs',),
    if(product.sku != null) (Icons.qr_code_2_rounded, 'SKU', product.sku!),
    if(dimensions != null)
      (Icons.straighten_rounded, 'Dimensions', '${dimensions.width} × ${dimensions.height} × ${dimensions.depth}',
      ),
  ];

  if(rows.isEmpty) return const SizedBox.shrink();

  return Card(
    child: Padding(padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        for(var i = 0; i < rows.length; i++) ...[
          if(i > 0) const Divider(height: 24,),
          _InfoRow(icon: rows[i].$1, label: rows[i].$2, value: rows[i].$3),
        ],
      ],
    ),),
  );
}

}


class _InfoRow extends StatelessWidget {

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

@override
Widget build(BuildContext context) {

  return Row(
    children: [
      Icon(icon,size: 20, color: context.colors.primary,),
      const SizedBox(width: 12,),
      Expanded(child: Text(
        label, style: context.textTheme.bodyMedium?.copyWith(
        color: context.colors.onSurfaceVariant,
      ),
      ),
      ),
      const SizedBox(width: 12,),
      Flexible(child: Text(
        value, textAlign: TextAlign.end,
        style: context.textTheme.titleSmall,
      ))
    ],
  );
}





}

