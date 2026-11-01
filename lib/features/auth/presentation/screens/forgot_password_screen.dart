import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/features/auth/application/auth_controller.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/auth_submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
 final _formkey = GlobalKey<FormState>();
 final _email = TextEditingController();
 bool _sent = false;

 @override
  void dispose() {
   _email.dispose();
   super.dispose();
 }

 Future<void> _submit() async {
   FocusScope.of(context).unfocus();
   if(!_formkey.currentState!.validate()) return;
   final ok = await ref
   .read(authControllerProvider.notifier)
   .sendPasswordReset(_email.text.trim());
   if(ok && mounted) setState(()  => _sent = true);
 }

 void _backToSignIn() {
   if(context.canPop()) {
     context.pop();
   }else {
     context.goNamed(RouteNames.login);
   }
 }

@override
Widget build(BuildContext context) {

  ref.listen(authControllerProvider, (previous, next) {
    if (next.hasError && !next.isLoading) {
      context.showSnackBar(failureMessage(next.error!), isError: true);
    }
  });
  
  final isLoading = ref.watch(authControllerProvider).isLoading;
  
  return Scaffold(
    appBar: AppBar(),
    body: SafeArea(child: SingleChildScrollView(padding: const .all(24),
    child: _sent ? _buildSent(context) : _buildForm(isLoading),
    )),
  );

   
}

Widget _buildForm (bool isLoading) {
   return Form(
       key: _formkey,
       autovalidateMode: .onUserInteraction,
       child: Column(
         crossAxisAlignment: .stretch,
         children: [
           const AuthHeader(title: 'Forgot password?', subTitle: "Enter your email and we'll send you a reset link.",
           ),
           const SizedBox(height: 32,),
           TextFormField(
             controller: _email,
             keyboardType: TextInputType.emailAddress,
             textInputAction: .done,
             validator: Validators.email,
             onFieldSubmitted: (_) => _submit(),
             decoration: const InputDecoration(
               labelText: 'Email',
               prefixIcon: Icon(Icons.mail_outline_rounded),
             ),
           ),
           const SizedBox(height: 24,),
           AuthSubmitButton(label: 'Send reset link', isLoading: isLoading, onPressed: _submit,)
         ],
       )
   );
   
}

Widget _buildSent(BuildContext context) {
   return Column(
     crossAxisAlignment: .stretch,
     children: [
       const SizedBox(height: 32,),
       Center(
         child: CircleAvatar(
           radius: 44,
           backgroundColor: context.colors.primaryContainer,
           child: Icon(
             Icons.mark_email_read_outlined,
             size: 44,
             color: context.colors.onPrimaryContainer,
           ),
         ),
       ),
       const SizedBox(height: 24,),
       Text(
         'Check your inbox',
         textAlign: .center,
         style: context.textTheme.headlineMedium,
       ),
       const SizedBox(height: 12,),
       Text(
         'If an account exists for ${_email.text.trim()}, a reset link is on '
             'its way. Check your spam folder too.',
         textAlign: TextAlign.center,
         style: context.textTheme.bodyLarge?.copyWith(
           color: context.colors.onSurfaceVariant,
         ),
       ),
       const SizedBox(height: 32,),
       FilledButton(onPressed: _backToSignIn,
           child: const Text('Back to sign in'),
       )
     ],
   );

}



}