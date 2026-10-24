import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class AppEmptyView  extends StatelessWidget{
  const AppEmptyView({
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
    super.key,
});

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(padding: const EdgeInsets.all(24),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: context.colors.outline,),
          const SizedBox(height: 16,),
          Text(title, textAlign: TextAlign.center,
          style: context.textTheme.titleLarge,),
          if(subtitle != null) ...[
            const SizedBox(height: 8,),
            Text(subtitle!, textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant,),),
          ],

          if(actionLabel != null && onAction != null) ...[
            const SizedBox(height: 24,),
            FilledButton(onPressed: onAction, child: Text(actionLabel!)),

    ],

        ],
      ),),


    );
  }

}