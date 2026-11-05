import 'package:e_commerce_app/core/providers/core_providers.dart';
import 'package:e_commerce_app/features/address/data/firestore_address_repository.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/address/domain/repositories/address_repository.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_providers.g.dart';

@Riverpod(keepAlive: true)
AddressRepository addressRepository(Ref ref) {
  return FirestoreAddressRepository(ref.watch(firestoreProvider));
}

@Riverpod(keepAlive: true)
Stream<List<Address>> addresses(Ref ref) {
  final uid = ref.watch(currentUidProvider);
  if (uid == null) return Stream.value(const <Address>[]);
  return ref.watch(addressRepositoryProvider).watchAddresses(uid);
}

/// The address checkout pre-selects (`null` when none saved).
@Riverpod(keepAlive: true)
Address? defaultAddress(Ref ref) {
  final list = ref.watch(addressesProvider).value;
  if (list == null || list.isEmpty) return null;
  return list.firstWhere((a) => a.isDefault, orElse: () => list.first);
}