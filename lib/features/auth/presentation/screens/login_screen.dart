import 'package:e_commerce_app/app/router/route_names.dart';
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

class LoginScreen extends ConsumerStatefulWidget {

  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if(!_formKey.currentState!.validate()) return;
    await ref.read(authControllerProvider.notifier).signIn(
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
                const AuthHeader(title: 'Welcome back', subTitle: 'Sign in to continue shopping.',
                ),
                const SizedBox(height: 32,),
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
                const SizedBox(height: 16,),
                PasswordField(controller: _password,
                  autofillHints: const [AutofillHints.password],
                validator: (value) => Validators.required(value, 'Password'),
                onSubmitted: (_) => _submit(),
                ),
                Align(
                  alignment: .centerRight,
                  child: TextButton(onPressed: () =>
                      context.pushNamed(RouteNames.forgotPassword),
                      child: const Text('Forgot password?'),
                  )
                ),
                const SizedBox(height: 8,),
                AuthSubmitButton(label: 'Sign in', isLoading: isLoading, onPressed: _submit,
                ),
                const SizedBox(height: 24,),
                SocialAuthSection(isLoading: isLoading, onGoogle: () => ref
                .read(authControllerProvider.notifier)
                .signInWithGoogle(),
                ),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: .center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(onPressed: () => context.pushNamed(RouteNames.signup),
                        child: const Text('Sign up'),
                    )
                  ],
                )
              ],
            )
        ),
      )),
    );
}

}