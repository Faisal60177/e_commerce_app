import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/features/auth/application/auth_controller.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/password_field.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/social_auth_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {

  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authControllerProvider.notifier).signUp(
      name: _name.text.trim(),
      email: _email.text.trim(),
      password: _password.text,
    );
  }


@override
Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if(next.hasError && !next.isLoading) {
        context.showSnackBar(failureMessage(next.error!), isError: true);
      }
    });

    final isLoading = ref.watch(authControllerProvider).isLoading;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: SingleChildScrollView(
        padding: const .all(24),
        child: Form(
          key: _formKey,
            autovalidateMode: .onUserInteraction,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                const AuthHeader(title: 'Create account', subTitle: "We'll email you a link to verify your address.",
                ),
                const SizedBox(height: 32,),
                TextFormField(
                  controller: _name,
                  textCapitalization: .words,
                  textInputAction: .next,
                  autofillHints: const [AutofillHints.name],
                  validator: Validators.name,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: .next,
                  autofillHints: const [AutofillHints.email],
                  validator: Validators.email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.mail_outline_rounded),

                  ),
                ),
                const SizedBox(height: 16),
                PasswordField(
                  controller: _password,
                  textInputAction: TextInputAction.next,
                  validator: Validators.password,
                ),
                const SizedBox(height: 16),
                PasswordField(
                  controller: _confirm,
                  label: 'Confirm password',
                  validator: Validators.confirmPassword(() => _password.text),
                  onSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: 24),
                AuthSubmitButton(
                  label: 'Create account',
                  isLoading: isLoading,
                  onPressed: _submit,
                ),
                const SizedBox(height: 24),
                SocialAuthSection(
                  isLoading: isLoading,
                  onGoogle: () => ref
                      .read(authControllerProvider.notifier)
                      .signInWithGoogle(),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: context.pop,
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ],
            )),
      )),
    );
}


}