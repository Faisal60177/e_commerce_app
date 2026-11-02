import 'dart:math' as math;

import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/core/utils/price_utils.dart';
import 'package:e_commerce_app/features/auth/application/require_auth.dart';
import 'package:e_commerce_app/features/cart/application/cart_actions.dart';
import 'package:e_commerce_app/features/cart/domain/cart_constants.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/quantity_stepper.dart';
import 'package:e_commerce_app/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddToCartBar extends ConsumerStatefulWidget {
  const AddToCartBar({required this.product, super.key});

  final Product product;

  @override
  ConsumerState<AddToCartBar> createState() => _AddToCartBarState();
}

class _AddToCartBarState extends ConsumerState<AddToCartBar> {
  int _quantity = 1;
  bool _busy = false;

  int get _max =>
      math.min(widget.product.stock, CartConstants.maxQuantityPerItem);

  Future<void> _add() async {
    final signedIn = await ref.ensureSignedIn(context);
    if (!signedIn || !mounted) return;

    final router = GoRouter.of(context);
    setState(() => _busy = true);
    try {
      final result = await ref
          .read(cartActionsProvider)
          .add(widget.product, quantity: _quantity);
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              result.limitReached
                  ? 'Maximum quantity per item reached.'
                  : 'Added to cart.',
            ),
            action: SnackBarAction(
              label: 'View cart',
              onPressed: () => router.goNamed(RouteNames.cart),
            ),
          ),
        );
    } on Failure catch (failure) {
      if (mounted) context.showSnack(failure.message, isError: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final inStock = _max > 0;
    final total = PriceUtils.roundMoney(
      widget.product.discountedPrice * _quantity,
    );

    return Material(
      elevation: 8,
      color: context.colors.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              if (inStock) ...[
                QuantityStepper(
                  quantity: _quantity,
                  max: _max,
                  onChanged: (quantity) => setState(() => _quantity = quantity),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: FilledButton.icon(
                  onPressed: inStock && !_busy ? _add : null,
                  icon: _busy
                      ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Icon(Icons.shopping_cart_outlined),
                  label: Text(
                    inStock
                        ? 'Add · ${Formatters.price(total)}'
                        : 'Out of stock',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}