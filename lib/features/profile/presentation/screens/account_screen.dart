import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/auth/application/auth_controller.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/sign_in_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  Future<void> _confirmSignOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out?'),
        content: const Text('You can sign back in anytime.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      await ref.read(authControllerProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authUserProvider).value;

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: user == null
          ? const SignInPrompt(
        icon: Icons.person_outline_rounded,
        title: 'Welcome to ShopEase',
        subtitle: 'Sign in to see your orders, addresses and settings.',
      )
          : ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ProfileHeader(user: user),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                _MenuTile(
                  icon: Icons.receipt_long_outlined,
                  label: 'My orders',
                  onTap: () => context.showSnackBar('Coming in a later step'),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.location_on_outlined,
                  label: 'Addresses',
                  onTap: () => context.showSnackBar('Coming in a later step'),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () => context.showSnackBar('Coming in a later step'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => _confirmSignOut(context, ref),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context) {
    final photo = user.photoUrl;

    return Row(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundColor: context.colors.primaryContainer,
          backgroundImage: photo == null ? null : CachedNetworkImageProvider(photo),
          child: photo == null
              ? Text(
            user.initial,
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.colors.onPrimaryContainer,
            ),
          )
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.displayLabel, style: context.textTheme.titleLarge),
              const SizedBox(height: 2),
              Text(
                user.email,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}