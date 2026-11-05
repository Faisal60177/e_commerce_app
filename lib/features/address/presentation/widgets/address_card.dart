import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
    super.key,
  });

  final Address address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  static IconData iconFor(AddressLabel label) => switch (label) {
    AddressLabel.home => Icons.home_outlined,
    AddressLabel.work => Icons.work_outline_rounded,
    AddressLabel.other => Icons.place_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(iconFor(address.label), color: colors.primary),
                const SizedBox(width: 8),
                Text(address.label.title, style: context.textTheme.titleMedium),
                const SizedBox(width: 8),
                if (address.isDefault)
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: Text(
                        'Default',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.onPrimaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(address.fullName, style: context.textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(
              address.formatted,
              style: context.textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 4),
            Text(
              address.phone,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              children: [
                TextButton(onPressed: onEdit, child: const Text('Edit')),
                if (!address.isDefault)
                  TextButton(
                    onPressed: onSetDefault,
                    child: const Text('Set as default'),
                  ),
                TextButton(
                  onPressed: onDelete,
                  style: TextButton.styleFrom(foregroundColor: colors.error),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}