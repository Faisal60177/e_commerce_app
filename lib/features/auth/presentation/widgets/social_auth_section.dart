import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class SocialAuthSection extends StatelessWidget {

const SocialAuthSection({
required this.isLoading,
required this.onGoogle,
super.key,
});

final bool isLoading;
final VoidCallback onGoogle;

@override
Widget build(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          const Expanded(child: Divider()),
          Padding(padding: const .symmetric(horizontal: 12),
          child: Text('or continue with',style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.outline,
          ),),),
          const Expanded(child: Divider()),
        ],
      ),
      const SizedBox(height: 16,),
      SizedBox(width: double.infinity,
      child: OutlinedButton.icon(onPressed: isLoading ? null : onGoogle, icon:  const Icon(Icons.g_mobiledata_rounded, size: 32,),
          label: const Text('Google'),
      ),)
    ],
  );
}



}