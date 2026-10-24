import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class AppErrorView  extends StatelessWidget{

  const AppErrorView({required this.message, this.onRetry, super.key});

final String message;
final VoidCallback? onRetry;

@override
  Widget build(BuildContext context) {
  return Center(
    child: Padding(padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.cloud_off_rounded, size: 56, color: context.colors.outline,),
        const SizedBox(height: 16,),
        Text(message, textAlign: TextAlign.center,
        style: context.textTheme.titleMedium,),
        if(onRetry != null) ...[
          const SizedBox(height: 20),
          FilledButton.tonalIcon(onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Try again'),
          )
        ]
      ],
    ),
    ),
  );

  }

}