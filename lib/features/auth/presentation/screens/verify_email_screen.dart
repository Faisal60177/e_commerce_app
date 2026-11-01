import 'dart:async';

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/auth/application/auth_controller.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  static const _resendCooldown = 60;

  Timer? _pollTimer;
  Timer? _cooldownTimer;
  int _cooldown = 0;

  @override
  void initState() {
    super.initState();
    _pollTimer = Timer.periodic(const Duration(seconds: 4),
        (_) => ref.read(authControllerProvider.notifier).refreshUser(silent: true),
    );
    _startCooldown(30);
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _cooldownTimer?.cancel();
    super.dispose();
  }
  
  void _startCooldown(int seconds) {
    _cooldownTimer?.cancel();
    setState(() => _cooldown = seconds);
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer){
      if(!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _cooldown--);
      if(_cooldown <= 0) timer.cancel();
    });
  }
  
  Future<void> _check() async {
    final verified = 
        await ref.read(authControllerProvider.notifier).refreshUser();
    if(!verified && mounted) {
      context.showSnackBar('Not verified yet. Check your inbox and spam folder.');
    }
  }
  
  Future<void> _resend() async {
    final sent = 
        await ref.read(authControllerProvider.notifier).sendVerificationEmail();
    if(!mounted) return;
    if(sent) {
      _startCooldown(_resendCooldown);
      context.showSnackBar('Verification email sent');
    }
  }

@override
Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if(next.hasError && !next.isLoading) {
        context.showSnackBar(failureMessage(next.error!),isError: true);
      }
    });
    final isLoading = ref.watch(authControllerProvider).isLoading;
    final email = ref.watch(authUserProvider).value?.email ?? '';
    return Scaffold(
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          padding: const .all(24),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: context.colors.primaryContainer,
                  child: Icon(
                    Icons.mark_email_unread_outlined,
                    size: 44,
                    color: context.colors.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              Text('Verify your email',textAlign: .center,
              style: context.textTheme.headlineMedium,),
              const SizedBox(height: 12),
              Text(
                'We sent a verification link to\n$email\n\n'
                    'Open it, then come back. This screen updates by itself.',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              FilledButton(onPressed: isLoading ? null : _check,
                  child: isLoading
              ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5,),
                  ) : const Text("I've verified my email"),
              ),
              const SizedBox(height: 12,),
              OutlinedButton(onPressed: (isLoading || _cooldown > 0) ? null : _resend, 
                  child: Text(_cooldown > 0 ? 'Resend email in ${_cooldown}s' : 'Resend email',
                  ),),
              const SizedBox(height: 8,),
              TextButton(onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
                  child: const Text('Use a different acccount'),
              )
            ],
          ),
        ),
      )),
    );
}


}


