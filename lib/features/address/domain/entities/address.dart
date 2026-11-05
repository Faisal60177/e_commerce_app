import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';

enum AddressLabel {
  home('Home'),
  work('Work'),
  other('Other');

  const AddressLabel(this.title);

  final String title;

  static AddressLabel fromName(String? name) {
    return values.firstWhere((l) => l.name == name, orElse: () => other);
  }
}

@freezed
abstract class Address with _$Address {
  const factory Address({
    required String fullName,
    required String phone,
    required String line1,
    required String city,
    required String region,
    required String postalCode,
    required String country,
    @Default('') String id,
    @Default(AddressLabel.home) AddressLabel label,
    @Default('') String line2,
    @Default(false) bool isDefault,
  }) = _Address;

  const Address._();

  String get cityLine => [city, region, postalCode]
      .where((part) => part.trim().isNotEmpty)
      .join(', ');

  String get formatted => [line1, line2, cityLine, country]
      .where((part) => part.trim().isNotEmpty)
      .join('\n');

  String get singleLine => formatted.replaceAll('\n', ', ');
}