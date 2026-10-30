import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {

  const AuthHeader({required this.title, required this.subTitle, super.key});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: context.colors.primaryContainer,
          child: Icon(Icons.shopping_bag_rounded,
          color: context.colors.onPrimaryContainer,),
        ),
    const SizedBox(height: 24,),
    Text(title, style: context.textTheme.headlineMedium,),
    const SizedBox(height: 8,),
    Text(subTitle, style: context.textTheme.bodyLarge?.copyWith(color: context.colors.onSurfaceVariant,
    ),)
      ],
    );
  }

}