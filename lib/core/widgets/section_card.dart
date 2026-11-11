import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class SectionCard  extends StatelessWidget{
  const SectionCard({
    required this.title,
    required this.child,
    this.trailing,
    super.key,
});

  final String title;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(padding: const .only(bottom: 8),
        child: Row(
          children: [
            Expanded(child: Text(title, style: context.textTheme.titleMedium,)),
            ?trailing,
          ],
        ),),
        SizedBox(width: double.infinity,
        child:  Card(
          child: Padding(padding: const .all(16),
          child: child,),
        ),)
      ],
    );
  }
}
