import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_banking/domain/auth/inputValiadation.dart';

void main() {
  var validator = InputValidationMixin();
  test("Password validation", () {
    bool actual = validator.isPasswordValid("123456kjh");
    expect(actual, true);
  });

  test("Email validation", () {
    bool actual = validator.isEmailValid("my@email.com");
    expect(actual, true);
  });
  test("Money validation", () {
    bool actual = validator.isValidMoney(-1);
    expect(actual, false);
  });
  test("Account number validation", () {
    bool actual = validator.isValidAccount(1000000009);
    expect(actual, true);
  });

  test("Date validation", () {
    bool actual = validator.isDateValid('11/09/21');
    expect(actual, true);
  });
  test("Name validation", () {
    bool actual = validator.isValidName('1');
    expect(actual, false);
  });
  test("PhoneNumber validation", () {
    bool actual = validator.isValidphoneNumber('123');
    expect(actual, false);
  });
}
