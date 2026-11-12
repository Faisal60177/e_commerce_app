import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';
import 'package:e_commerce_app/features/products/application/recent_searches_provider.dart';
import 'package:e_commerce_app/features/profile/application/profile_actions.dart';
import 'package:e_commerce_app/features/settings/application/app_info_provider.dart';
import 'package:e_commerce_app/features/settings/application/theme_mode_controller.dart';
import 'package:e_commerce_app/features/settings/presentation/widgets/delete_account_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _busy = false;

  Future<void> _clearSearches() async {
    await ref.read(recentSearchesProvider.notifier).clear();
    if(mounted) context.showSnack('Recent searches cleared');
  }

  Future<void> _deleteAccount(AppUser user) async {
    final password = await showDialog<String>(
        context: context, builder: (context) => DeleteAccountDialog(needsPassword: user.hasPassword),
    );
    if(password == null || !mounted) return;

    final router = GoRouter.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _busy = true);

    try{
      await ref
          .read(profileActionsProvider)
          .deleteAccount(password: user.hasPassword ? password : null);
      router.goNamed(RouteNames.home);
      messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Your account was deleted')));
    } on Failure catch (failure) {
      if (mounted) context.showSnack(failure.message, isError: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }


@override
Widget build(BuildContext context) {
  final user = ref.watch(authUserProvider).value;
  final mode = ref.watch(themeModeControllerProvider);
  final info = ref.watch(packageInfoProvider).value;
  final version = info == null ? '-' : '${info.version} (${info.buildNumber})';
  final colors = context.colors;

  return Scaffold(
    appBar: AppBar(title: const Text('Settings'),),
    body: AbsorbPointer(
      absorbing: _busy,
      child: ListView(
        padding: const .all(16),
        children: [
          if(_busy) const LinearProgressIndicator(),
          const _SectionTitle('Appearance'),
          Card(
            child: Padding(padding: const.all(16),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text('Theme', style: context.textTheme.titleSmall,),
                const SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ThemeMode>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(value: ThemeMode.system,
                        icon: Icon(Icons.brightness_auto_rounded,),
                        label: Text('System'),
                        ),
                        ButtonSegment(value: ThemeMode.light,
                        icon: Icon(Icons.light_mode_outlined),
                        label: Text('Light'),
                        ),
                        ButtonSegment(value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode_outlined),
                        label: Text('Dark'),
                        )
                      ], selected: {mode},
                  onSelectionChanged: (selection) => ref
                    .read(themeModeControllerProvider.notifier)
                    .setMode(selection.first),
                  ),
                )
              ],
            ),),
          ),
          const _SectionTitle('Data'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.history_rounded),
              title: const Text('Clear recent searches'),
              onTap: _clearSearches,
            ),
          ),
          if(user != null) ...[
            const _SectionTitle('Account'),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline_rounded),
                    title: const Text('Edit profile'),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => context.pushNamed(RouteNames.editProfile),
                  ),
                  if( user.hasPassword) ...[
                    const Divider(height: 1,),
                    ListTile(
                      leading: const Icon(Icons.lock_reset_rounded),
                      title: const Text('Change password'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () =>
                          context.pushNamed(RouteNames.changePassword),
                    )
                  ],
                  const Divider(height: 1,),
                  ListTile(
                    leading: Icon(Icons.delete_forever_outlined,
                    color: colors.error,
                    ),
                    title: Text(
                      'Delete account',
                      style: TextStyle(color: colors.error),
                    ),
                    onTap: () => _deleteAccount(user),
                  )
                ],
              ),
            )
          ],
          const _SectionTitle('About'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: const Text('Version'),
                  trailing: Text(version),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: const Text('Open-source licenses'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => showLicensePage(context: context,
                  applicationName: 'ShopEase',
                  applicationVersion: info?.version,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Portfolio demo app. Product data comes from DummyJSON, and '
                'payments are simulated (Cash on Delivery only).',
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(color: colors.outline),
          ),
          const SizedBox(height: 16,),
        ],
      ),
    ),
  );
}
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

@override
Widget build(BuildContext context) {
  return Padding(padding: const .fromLTRB(4, 24, 4, 8),
  child: Text(
    text.toUpperCase(),
    style: context.textTheme.labelMedium?.copyWith(
      color: context.colors.primary,
      letterSpacing: 1,
    ),
  ),);
}
}