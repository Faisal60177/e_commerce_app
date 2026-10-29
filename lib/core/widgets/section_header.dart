import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({required this.title, this.onSeeAll, super.key});

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
    child: Row(
      children: [
        Expanded(child: Text(title, style: context.textTheme.titleLarge,)),
        if(onSeeAll != null)
          TextButton(onPressed: onSeeAll, child: const Text('See all')),
      ],
    ),
    );


  }
}