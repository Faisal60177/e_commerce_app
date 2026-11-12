import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators.email', () {
    test('accepts valid and rejects invalid addresses', () {
      expect(Validators.email('mohammad@example.com'), isNull);
      expect(Validators.email(' mohammad@example.com '), isNull);
      expect(Validators.email(''), isNotNull);
      expect(Validators.email('not-an-email'), isNotNull);
      expect(Validators.email('a@b'), isNotNull);
    });
  });

  group('Validators.password', () {
    test('requires 8+ characters with letters and numbers', () {
      expect(Validators.password('abc12345'), isNull);
      expect(Validators.password('short1'), isNotNull);
      expect(Validators.password('onlyletters'), isNotNull);
      expect(Validators.password('12345678'), isNotNull);
      expect(Validators.password(''), isNotNull);
    });

    test('confirmPassword compares with the original', () {
      final validate = Validators.confirmPassword(() => 'abc12345');
      expect(validate('abc12345'), isNull);
      expect(validate('different1'), isNotNull);
      expect(validate(''), isNotNull);
    });
  });

  group('Validators.phone', () {
    test('accepts common formats', () {
      expect(Validators.phone('+8801700000000'), isNull);
      expect(Validators.phone('(555) 123-4567'), isNull);
    });

    test('rejects letters and wrong lengths', () {
      expect(Validators.phone('abc'), isNotNull);
      expect(Validators.phone('123'), isNotNull);
      expect(Validators.phone(''), isNotNull);
    });

    test('optionalPhone allows empty but validates content', () {
      expect(Validators.optionalPhone(''), isNull);
      expect(Validators.optionalPhone(null), isNull);
      expect(Validators.optionalPhone('12'), isNotNull);
    });
  });
}