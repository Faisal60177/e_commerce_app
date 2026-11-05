import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/features/address/application/address_providers.dart';
import 'package:e_commerce_app/features/address/domain/entities/address.dart';
import 'package:e_commerce_app/features/address/domain/repositories/address_repository.dart';
import 'package:e_commerce_app/features/auth/application/auth_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'address_actions.g.dart';

@Riverpod(keepAlive: true)

AddressActions addressActions(Ref ref) => AddressActions(ref);
class AddressActions {
  AddressActions(this._ref);
  final Ref _ref;

  AddressRepository get _repository => _ref.read(addressRepositoryProvider);

  String get _uid {
    final uid = _ref.read(currentUidProvider);
    if(uid == null) throw const AuthFailure('Please sign in first');
    return uid;
  }

  Future<void> save (Address address) => _repository.save(_uid, address);
  Future<void> delete (String addressId) => _repository.delete(_uid, addressId);
  Future<void> setDefault(String addressId) =>
      _repository.setDefault(_uid, addressId);
}