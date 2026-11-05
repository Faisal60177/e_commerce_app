import 'package:e_commerce_app/features/address/domain/entities/address.dart';

abstract interface class AddressRepository {
  Stream<List<Address>> watchAddresses(String uid);

  Future<void> save(String uid, Address address);
  Future<void> delete(String uid, String addressId);
  Future<void> setDefault(String uid, String addressId);
}