import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/auth/application/auth_controller.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/sign_in_prompt.dart';
import 'package:e_commerce_app/features/profile/application/profile_providers.dart';
import 'package:e_commerce_app/features/profile/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.pushNamed(RouteNames.settings),
          ),
        ],
      ),
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
                  onTap: () => context.pushNamed(RouteNames.orders),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.favorite_border_rounded,
                  label: 'Wishlist',
                  onTap: () => context.goNamed(RouteNames.wishlist),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.location_on_outlined,
                  label: 'Addresses',
                  onTap: () => context.pushNamed(RouteNames.addresses),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.person_outline_rounded,
                  label: 'Edit profile',
                  onTap: () => context.pushNamed(RouteNames.editProfile),
                ),
                const Divider(height: 1),
                _MenuTile(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () => context.pushNamed(RouteNames.settings),
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

class _ProfileHeader extends ConsumerWidget {
  const _ProfileHeader({required this.user});

  final AppUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider).value;
    final phone = profile?.phone ?? '';

    return Row(
      children: [
        UserAvatar(user: user, avatarIndex: profile?.avatarIndex ?? 0),
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
              if (phone.isNotEmpty)
                Text(
                  phone,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Edit profile',
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => context.pushNamed(RouteNames.editProfile),
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