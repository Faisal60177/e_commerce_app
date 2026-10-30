import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';

class AddToCartBar extends StatelessWidget {
  const AddToCartBar({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      color: context.colors.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Price',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.outline,
                    ),
                  ),
                  Text(
                    Formatters.price(product.discountedPrice),
                    style: context.textTheme.titleLarge?.copyWith(
                      color: context.colors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: FilledButton.icon(
                  onPressed: product.isInStock
                      ? () => context.showSnackBar('Cart arrives in the next step')
                      : null,
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: Text(product.isInStock ? 'Add to cart' : 'Out of stock'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}