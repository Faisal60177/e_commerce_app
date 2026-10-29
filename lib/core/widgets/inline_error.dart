import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class InlineError extends StatelessWidget {
  const InlineError({required this.message, required this.onRetry, super.key});

  final String message;
  final VoidCallback onRetry;

@override
Widget build(BuildContext context) {
  
  return Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: Row(
    children: [
      Icon(Icons.error_outline_rounded, color: context.colors.error,),
      const SizedBox(width: 12,),
      Expanded(child: Text(message, style: context.textTheme.bodyMedium,)),
      TextButton(onPressed: onRetry, child: const Text('Retry')),
    ],
  ),
  );
  
  
}



}