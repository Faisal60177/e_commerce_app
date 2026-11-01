import 'package:flutter/material.dart';

class AuthSubmitButton extends StatelessWidget{

  const AuthSubmitButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
    super.key,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

@override
Widget build(BuildContext context) {
  return FilledButton(onPressed: isLoading ? null : onPressed,
      child: isLoading ? const SizedBox.square(dimension: 22,
      child: CircularProgressIndicator(strokeWidth: 2.5),
      ) : Text(label),
  );
}
}