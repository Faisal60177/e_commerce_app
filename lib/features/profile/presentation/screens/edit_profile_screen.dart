import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:e_commerce_app/features/auth/domain/entities/app_user.dart';
import 'package:e_commerce_app/features/profile/application/profile_actions.dart';
import 'package:e_commerce_app/features/profile/application/profile_providers.dart';
import 'package:e_commerce_app/features/profile/domain/entities/user_profile.dart';
import 'package:e_commerce_app/features/profile/presentation/avatar_palette.dart';
import 'package:e_commerce_app/features/profile/presentation/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen  extends ConsumerWidget{
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authUserProvider).value;
    final profile = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit profile'),),
      body: user == null
      ? const SizedBox.shrink()
      : profile.when(
        loading: () => const Center(child: CircularProgressIndicator(),),
        error:(error, stackTrace) => AppErrorView(message: failureMessage(error),
        onRetry: () => ref.invalidate(userProfileProvider),
        ),
        data: (profile) => _EditProfileForm(user: user, profile: profile),
      ),
    );
  }
}

class _EditProfileForm extends ConsumerStatefulWidget{
  const _EditProfileForm({required this.user, required this.profile});

  final AppUser user;
  final UserProfile profile;

  @override
  ConsumerState<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<_EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late final _name = TextEditingController(text: widget.user.displayName ?? '');
  late final _phone = TextEditingController(text: widget.profile.phone);
  late int _avatar = widget.profile.avatarIndex;
  bool _saving = false;

  bool get _hasPhoto => (widget.user.photoUrl ?? '').isNotEmpty;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if(!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    try {
      await ref.read(profileActionsProvider).save(
        name: _name.text,
        phone: _phone.text,
        avatarIndex: _avatar,
      );
      if(!mounted) return;
      context
      ..showSnack('Profile updated')
      ..pop();
    } on Failure catch (failure) {
      if(mounted) context.showSnack(failure.message, isError: true);
    } finally {
      if (mounted) {
        setState(() =>
        _saving = false);
      }
    }
  }
@override
Widget build(BuildContext context) {

    return SafeArea(child: SingleChildScrollView(
      padding: const .all(16),
      child: Form(
          key: _formKey,
          autovalidateMode: .onUserInteraction,
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Center(
                child: ListenableBuilder(listenable: _name, builder: (context, _) => UserAvatar(
                    user: widget.user.copyWith(displayName: _name.text),
                avatarIndex: _avatar,
                radius: 48,
                )),
              ),
              const SizedBox(height: 16,),
              _hasPhoto ?
                Text('Your photo comes from your Google account.',
                textAlign: .center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.outline,
                ),)
              : Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    for(var i = 0; i < AvatarPalette.colors.length; i++)
                      GestureDetector(
                        onTap: () => setState(() => _avatar = i),
                        child: AnimatedContainer(duration: const Duration(milliseconds: 150),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AvatarPalette.colors[i],
                          shape: BoxShape.circle,
                          border: .all(
                            color: _avatar == i ? context.colors.onSurface
                                : Colors.transparent,
                            width: 3,
                          )
                        ),
                        child: _avatar == i
                          ? const Icon(Icons.check_rounded,
                        color: Colors.white,
                        size: 20,)
                          : null,
                        ),
                      )
                  ],
                ),
              const SizedBox(height: 24,),
              TextFormField(
                controller: _name,
                textCapitalization: .words,
                textInputAction: .next,
                autofillHints: const [AutofillHints.name],
                validator: Validators.name,
                decoration: const InputDecoration(
                  labelText:'Full Name',
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phone,
                keyboardType: TextInputType.phone,
                textInputAction: .done,
                autofillHints: const[AutofillHints.telephoneNumber],
                validator: Validators.optionalPhone,
                onFieldSubmitted: (_) => _save(),
                decoration: const InputDecoration(
                  labelText: 'Phone number (optional)',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.user.email,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  helperText: "Email can't be changed here.",
                  prefixIcon: Icon(Icons.mail_outline_rounded),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: _saving ? null : _save,
                  child: _saving ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5,),
                  )
              : const Text('Save changes'),
              )
            ],
          )),
    ));
}
}