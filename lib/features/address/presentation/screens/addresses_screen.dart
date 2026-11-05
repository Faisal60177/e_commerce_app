import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/widgets/app_empty_view.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/core/widgets/shimmer_box.dart';
import 'package:e_commerce_app/features/address/application/address_actions.dart';
import 'package:e_commerce_app/features/address/application/address_providers.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddressesScreen extends ConsumerWidget {
  const AddressesScreen({super.key});

  Future<void> _delete(
      BuildContext context,
      WidgetRef ref,
      Address address,
      ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete address?'),
        content: Text(address.singleLine),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false)) return;

    try {
      await ref.read(addressActionsProvider).delete(address.id);
    } on Failure catch (failure) {
      if (context.mounted) context.showSnack(failure.message, isError: true);
    }
  }

  Future<void> _setDefault(
      BuildContext context,
      WidgetRef ref,
      Address address,
      ) async {
    try {
      await ref.read(addressActionsProvider).setDefault(address.id);
    } on Failure catch (failure) {
      if (context.mounted) context.showSnack(failure.message, isError: true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(addressesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My addresses')),
      body: addresses.when(
        loading: () => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) =>
          const ShimmerBox(height: 170, radius: 16),
        ),
        error: (error, stackTrace) => AppErrorView(
          message: failureMessage(error),
          onRetry: () => ref.invalidate(addressesProvider),
        ),
        data: (items) => items.isEmpty
            ? const AppEmptyView(
          icon: Icons.location_off_outlined,
          title: 'No saved addresses',
          subtitle: 'Add an address to speed up checkout.',
        )
            : ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final address = items[index];
            return AddressCard(
              address: address,
              onEdit: () => context.pushNamed(
                RouteNames.editAddress,
                pathParameters: {'id': address.id},
              ),
              onDelete: () => _delete(context, ref, address),
              onSetDefault: () => _setDefault(context, ref, address),
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton.icon(
            onPressed: () => context.pushNamed(RouteNames.addAddress),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Add new address'),
          ),
        ),
      ),
    );
  }
}