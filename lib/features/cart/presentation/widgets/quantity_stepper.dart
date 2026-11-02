import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class QuantityStepper  extends StatelessWidget{

  const QuantityStepper({
    required this.quantity,
    required this.onChanged,
    this.min = 1,
    this.max = 10,
    super.key,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

@override
Widget build(BuildContext context) {

  return DecoratedBox(decoration: BoxDecoration(
    color: context.colors.surfaceContainerHighest.withValues(alpha: 0.6),
    borderRadius: .circular(12),
  ),
  child: Row(
    mainAxisSize: .min,
    children: [
      _StepButton(
        icon: Icons.remove_rounded,
        onPressed: quantity > min ? () => onChanged(quantity - 1) : null,
      ), SizedBox(width: 28,
      child:  Text('$quantity',textAlign: .center,
      style: context.textTheme.titleSmall,
      ),),
      _StepButton(
        icon: Icons.add_rounded,
        onPressed: quantity < max ? () => onChanged(quantity + 1) : null,
      )


    ],
  ),);
}
}

class _StepButton extends StatelessWidget{

  const _StepButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback? onPressed;

@override
Widget build(BuildContext context) {
  return IconButton(onPressed: onPressed,
      icon: Icon(icon, size:  18,),
  padding: .zero,
  visualDensity: .compact,
  constraints: const BoxConstraints.tightFor(width: 36, height: 36),
  );
}

}