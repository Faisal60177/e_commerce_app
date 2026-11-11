import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/address/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';

class AddressSummary extends StatelessWidget {

const AddressSummary({required this.address, super.key});

final Address address;

@override
Widget build(BuildContext context) {
  return Row(
    crossAxisAlignment: .start,
    children: [
      Icon(AddressCard.iconFor(address.label), color: context.colors.primaryContainer,),
      const SizedBox(width: 12,),
      Expanded(child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(address.fullName, style: context.textTheme.titleSmall,),
          const SizedBox(height: 4,),
          Text(
            address.formatted,
            style: context.textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
          const SizedBox(height: 4,),
          Text(address.phone,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),)
        ],
      ))
    ],
  );


}

}