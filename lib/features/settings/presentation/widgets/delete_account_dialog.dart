import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';

class DeleteAccountDialog extends StatefulWidget{
  const DeleteAccountDialog({required this.needsPassword, super.key});

  final bool needsPassword;

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final _password = TextEditingController();

@override
void dispose() {
_password.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
  return AlertDialog(
    title: const Text('Delete Account?'),
    content: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        const Text(
          'This permanently deletes your account, cart, wishlist, addresses '
              'and order history. This cannot be undone.',
        ),
        if(widget.needsPassword) ...[
          const SizedBox(height: 16,),
          PasswordField(controller: _password,
          label: 'Confirm your password',
          )
        ]
      ],
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
      ),
      ListenableBuilder(listenable: _password, builder: (context, _) {
        final canConfirm =
            !widget.needsPassword || _password.text.isNotEmpty;
        return FilledButton(onPressed: canConfirm ? () => Navigator.pop(context, _password.text)
            : null, style: FilledButton.styleFrom(backgroundColor: context.colors.error,
        foregroundColor: context.colors.onError,
        ),
            child: const Text('Delete'),
        );
      })
    ],
  );

}
}