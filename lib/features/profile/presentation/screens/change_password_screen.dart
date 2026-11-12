import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/password_field.dart';
import 'package:e_commerce_app/features/profile/application/profile_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _current.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if(!_formKey.currentState!.validate()) return;

    setState(() => _saving =true);

    try {
      await ref.read(profileActionsProvider).changePassword(
        currentPassword: _current.text,
        newPassword: _new.text,
      );
      if (!mounted) return;
      context
        ..showSnack('Password updated')
        ..pop();
    } on Failure catch (failure) {
      if (mounted) context.showSnack(failure.message, isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

@override
Widget build(BuildContext context) {
    final user = ref.watch(authUserProvider).value;
    
    return Scaffold(
      appBar: AppBar(title:  const Text('Change password'),),
      body: SafeArea(child: user != null && !user.hasPassword
      ? Padding(padding: const.all(24),
      child: Text(
        'Your account signs in with Google, so there is no password '
            'to change.',
        style: context.textTheme.bodyLarge,
      ),)
      : SingleChildScrollView(
        padding: const.all(16),
        child: Form(
          key: _formKey,
            autovalidateMode: .onUserInteraction,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                PasswordField(controller: _current,label: 'Current Password',
                textInputAction: .next,
                validator: (v) =>
                  Validators.required(v, 'Current password'),
                ),
                const SizedBox(height: 16,),
                PasswordField(controller: _new,
                label: 'New password',
                textInputAction: .next,
                validator: (value) {
                  final error = Validators.password(value);
                  if(error != null) return error;
                  if(value == _current.text) {
                    return 'Choose a different password';
                  }
                  return null;
                },),
                const SizedBox(height: 16,),
                PasswordField(controller: _confirm,
                label: 'Confirm new password',
                validator: Validators.confirmPassword(()=> _new.text),
                onSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 24,),
                AuthSubmitButton(label: 'Update password', isLoading: _saving, onPressed: _submit,
                )
              ],
            )),
      )),
    );
    
    
}

  }
  