import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/features/address/application/address_actions.dart';
import 'package:e_commerce_app/features/address/application/address_providers.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddressFormScreen extends ConsumerWidget {
  const AddressFormScreen({this.addressId, super.key});

  final String? addressId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(addressesProvider);
    final user = ref.watch(authUserProvider).value;

    return addresses.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        appBar: AppBar(),
        body: AppErrorView(
          message: failureMessage(error),
          onRetry: () => ref.invalidate(addressesProvider),
        ),
      ),
      data: (list) {
        Address? initial;
        if (addressId != null) {
          initial = list.where((a) => a.id == addressId).firstOrNull;
          if (initial == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const AppErrorView(message: 'Address not found.'),
            );
          }
        }

        return _AddressForm(
          initial: initial,
          isFirst: list.isEmpty,
          suggestedName: user?.displayName,
        );
      },
    );
  }
}

class _AddressForm extends ConsumerStatefulWidget {
  const _AddressForm({
    required this.initial,
    required this.isFirst,
    required this.suggestedName,
  });

  final Address? initial;
  final bool isFirst;
  final String? suggestedName;

  @override
  ConsumerState<_AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends ConsumerState<_AddressForm> {
  final _formKey = GlobalKey<FormState>();

  late final _name = TextEditingController(
    text: widget.initial?.fullName ?? widget.suggestedName ?? '',
  );
  late final _phone = TextEditingController(text: widget.initial?.phone);
  late final _line1 = TextEditingController(text: widget.initial?.line1);
  late final _line2 = TextEditingController(text: widget.initial?.line2);
  late final _city = TextEditingController(text: widget.initial?.city);
  late final _region = TextEditingController(text: widget.initial?.region);
  late final _postal = TextEditingController(text: widget.initial?.postalCode);
  late final _country = TextEditingController(text: widget.initial?.country);

  late AddressLabel _label = widget.initial?.label ?? AddressLabel.home;
  late bool _isDefault = widget.initial?.isDefault ?? widget.isFirst;
  bool _saving = false;

  bool get _defaultLocked => widget.initial?.isDefault ?? widget.isFirst;

  @override
  void dispose() {
    for (final controller in [
      _name,
      _phone,
      _line1,
      _line2,
      _city,
      _region,
      _postal,
      _country,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);
    final address = Address(
      id: widget.initial?.id ?? '',
      label: _label,
      fullName: _name.text,
      phone: _phone.text,
      line1: _line1.text,
      line2: _line2.text,
      city: _city.text,
      region: _region.text,
      postalCode: _postal.text,
      country: _country.text,
      isDefault: _isDefault,
    );

    try {
      await ref.read(addressActionsProvider).save(address);
      if (mounted) context.pop();
    } on Failure catch (failure) {
      if (mounted) context.showSnack(failure.message, isError: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initial != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit address' : 'Add address')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SegmentedButton<AddressLabel>(
                  segments: [
                    for (final label in AddressLabel.values)
                      ButtonSegment(value: label, label: Text(label.title)),
                  ],
                  selected: {_label},
                  onSelectionChanged: (selection) =>
                      setState(() => _label = selection.first),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _name,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  validator: Validators.name,
                  decoration: const InputDecoration(labelText: 'Full name'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.telephoneNumber],
                  validator: Validators.phone,
                  decoration: const InputDecoration(labelText: 'Phone number'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _line1,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.streetAddressLine1],
                  validator: (v) => Validators.required(v, 'Address'),
                  decoration: const InputDecoration(
                    labelText: 'Address line 1',
                    hintText: 'House, street, area',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _line2,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Address line 2 (optional)',
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _city,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.addressCity],
                        validator: (v) => Validators.required(v, 'City'),
                        decoration: const InputDecoration(labelText: 'City'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _region,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.addressState],
                        validator: (v) =>
                            Validators.required(v, 'State / region'),
                        decoration: const InputDecoration(
                          labelText: 'State / region',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _postal,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.postalCode],
                        validator: (v) => Validators.required(v, 'Postal code'),
                        decoration: const InputDecoration(
                          labelText: 'Postal code',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _country,
                        textCapitalization: TextCapitalization.words,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.countryName],
                        validator: (v) => Validators.required(v, 'Country'),
                        onFieldSubmitted: (_) => _save(),
                        decoration: const InputDecoration(labelText: 'Country'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Set as default address'),
                  value: _isDefault,
                  onChanged: _defaultLocked
                      ? null
                      : (value) => setState(() => _isDefault = value),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  child: _saving
                      ? const SizedBox.square(
                    dimension: 22,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                      : Text(isEditing ? 'Save changes' : 'Save address'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}