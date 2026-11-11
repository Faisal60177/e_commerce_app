import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/formatters.dart';
import 'package:e_commerce_app/core/widgets/app_empty_view.dart';
import 'package:e_commerce_app/core/widgets/line_item_row.dart';
import 'package:e_commerce_app/core/widgets/section_card.dart';
import 'package:e_commerce_app/features/address/application/address_providers.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/address_card.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/address_summary.dart';
import 'package:e_commerce_app/features/cart/application/cart_providers.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_item.dart';
import 'package:e_commerce_app/features/cart/domain/entities/cart_totals.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/price_breakdown.dart';
import 'package:e_commerce_app/features/orders/application/order_actions.dart';
import 'package:e_commerce_app/features/orders/domain/entities/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  static const _addNew = '__new__';

  final _note = TextEditingController();
  String? _addressId;
  bool _placing = false;

  List<CartItem> _frozen = const [];

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Address? _selected(List<Address> addresses, Address? fallback) {
    if(_addressId != null) {
      final match = addresses.where((a) => a.id == _addressId).firstOrNull;
      if(match != null) return match;
    }
    return fallback;
  }

  Future<void> _changeAddress(List<Address> addresses, Address? selected) async {
    final result = await showModalBottomSheet<String>(
        context: context,
        showDragHandle: true,
        builder: (context) => SafeArea(
            child: Column(
              mainAxisSize: .min,
              children: [
                Padding(padding: const .fromLTRB(16, 0, 16, 8),
                child: Align(
                  alignment: .centerLeft,
                  child: Text(
                    'Choose delivery address',
                    style: context.textTheme.titleLarge,
                  ),
                ),),
                Flexible(child: ListView(
                  shrinkWrap: true,
                  children: [
                    for(final address in addresses)
                      ListTile(
                        leading: Icon(AddressCard.iconFor(address.label)),
                        title: Text('${address.label.title} . ${address.fullName}'),
                        subtitle: Text(
                          address.singleLine,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: address.id == selected?.id
                        ? Icon(
                          Icons.check_circle_rounded,
                          color: context.colors.primary,
                        )
                        : null,
                        onTap: () => Navigator.pop(context, address.id),
                      )
                  ],
                )),
                Padding(padding: const .all(16),
                child: SizedBox(width: double.infinity,
                    child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context, _addNew),
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Add new address'),
                    ),),)
              ],
            )));

    if(!mounted || result == null) return;
    if(result == _addNew) {
      await context.pushNamed(RouteNames.addAddress);
      return;
    }
    setState(() => _addressId = result);
  }

  Future<void> _place(Address address) async {
    FocusScope.of(context).unfocus();
    final router = GoRouter.of(context);

    setState(() {
      _frozen = ref.read(cartItemsProvider).value ?? const <CartItem>[];
      _placing = true;
    });

    try {
      final orderId = await ref.read(orderActionsProvider).placeOrder(
          address: address, paymentMethod: PaymentMethod.cashOnDelivery,
      note: _note.text,
      );
      router.goNamed(RouteNames.orderSuccess, pathParameters: {'id' : orderId});
    } on Failure catch (failure) {
      if(!mounted) return;
      setState(() => _placing = false);
      context.showSnack(failure.message, isError: true);
    }
  }

@override
Widget build(BuildContext context) {
    final cart = ref.watch(cartItemsProvider);
    final addressState = ref.watch(addressesProvider);
    final addresses = addressState.value ?? const <Address>[];
    final address = _selected(addresses, ref.watch(defaultAddressProvider));

    if(!_placing && !cart.hasValue) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout'),),
        body: const Center(child: CircularProgressIndicator(),),
      );
    }

    final items = _placing ? _frozen : (cart.value ?? const <CartItem>[]);
    if(items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout'),),
        body: AppEmptyView(icon: Icons.shopping_cart_outlined, title: 'Your cart is empty',
        actionLabel: 'Back to shopping',
        onAction: () => context.goNamed(RouteNames.home),
        ),
      );
    }

    final totals = CartTotals.from(items);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'),),
      body: ListView(
        padding: const .all(16),
        children: [
          SectionCard(title: 'Delivery address',
              trailing: address == null
              ? null : TextButton(onPressed: _placing ? null : () => _changeAddress(addresses, address),
                  child: const Text('Change'),
              ),
              child: !addressState.hasValue
          ? const Center(child: CircularProgressIndicator(),)
          : address == null ? _NoAddress(
                onAdd: () => context.pushNamed(RouteNames.addresses),
              ) : AddressSummary(address: address),
          ),
          const SizedBox(height: 20,),
          SectionCard(title: 'Items (${totals.itemCount})',
              child: Column(
                children: [
                  for(var i = 0; i< items.length; i++) ...[
                    LineItemRow(
                      title: items[i].title,
                      thumbnail: items[i].thumbnail,
                      unitPrice: items[i].unitPrice,
                      quantity: items[i].quantity,
                      lineTotal: items[i].lineTotal,
                        ),
                  ]
                ],
              )),
          const SizedBox(height: 20,),
          const SectionCard(title: 'Payment', child: _PaymentMethodRow()),
          const SizedBox(height: 20,),
          SectionCard(title: 'Order note', child: TextField(
            controller: _note,
            maxLines: 2,
            maxLength: 200,
            textCapitalization: .sentences,
            decoration: const InputDecoration(
              hintText: 'Delivery instructions (optional)',
            ),
          )),
          const SizedBox(height: 20),
          SectionCard(title: 'Order summary', child: PriceBreakdown(subtotal: totals.listSubtotal,
              discount: totals.savings, shipping: totals.shipping, total: totals.total,
          )),
          const SizedBox(height: 8,),
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 8,
        color: context.colors.surface,
        child: SafeArea(
            top: false,
            child: Padding(padding: const .fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      'Total',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.outline,
                      ),
                    ),
                    Text(
                      Formatters.price(totals.total),
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(child: FilledButton(onPressed: (address == null || _placing) ? null : () => _place(address),
                    child: _placing
                ? const SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5,),
                    ) : const Text('Place order'),
                ))
              ],
            ),)),
      ),
    );
 }
}

class _NoAddress extends StatelessWidget {
const _NoAddress({required this.onAdd});

final VoidCallback onAdd;

@override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: .start,
    children: [
      Text('Add a delivery address to place your order.',style: context.textTheme.bodyMedium,
      ),
      const SizedBox(height: 12,),
      FilledButton.tonalIcon(onPressed: onAdd, icon: const Icon(Icons.add_location_alt_outlined), label: const Text('Add address'),
      )
    ],
  );
}
}

class _PaymentMethodRow extends StatelessWidget {
const _PaymentMethodRow();

@override
Widget build(BuildContext context) {
  const method = PaymentMethod.cashOnDelivery;
  return Column(
    crossAxisAlignment: .start,
    children: [
      Row(
        children: [
          Icon(Icons.payment_outlined, color: context.colors.primary,),
          const  SizedBox(width: 12,),
          Expanded(child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(method.title, style: context.textTheme.titleSmall,),
              Text(
                method.description,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              )
            ],
          )),
          Icon(Icons.check_circle_rounded,color: context.colors.primary,),
        ],
      ),
      const SizedBox(height: 12,),
      Text(
        'Online payment is not available in this demo.',
        style: context.textTheme.bodySmall?.copyWith(
          color: context.colors.outline,
        ),
      )
    ],
  );


}


}