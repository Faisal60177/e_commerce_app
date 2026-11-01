import 'package:e_commerce_app/app/router/route_names.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInPrompt extends StatelessWidget {

  const SignInPrompt({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });
  
final IconData icon;
  final String title;
  final String subtitle;

@override
Widget build(BuildContext context) {
  return Center(
    child: Padding(padding: const .all(24),
    child: Column(
      mainAxisSize: .min,
      children: [
        Icon(icon, size: 72, color:context.colors.outline),
        const SizedBox(height: 16,),
        Text(title,textAlign: .center,
        style: context.textTheme.titleLarge,),
        const SizedBox(height: 8,),
        Text(subtitle,textAlign: .center,style: context.textTheme.bodyMedium?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),),
        const SizedBox(height: 24,),
        FilledButton(onPressed: () => context.pushNamed(RouteNames.login, queryParameters: {
          'from' : GoRouterState.of(context).uri.toString(),
        }), child: const Text('Sign in'),
        ),
        const SizedBox(height: 8,),
        TextButton(onPressed: ()=> context.pushNamed(RouteNames.signup), child: const Text('Create an account'),
        )
      ],
    ),
    ),
  );
  
  
  
}
  
}

