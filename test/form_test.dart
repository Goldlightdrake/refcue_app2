import 'package:flutter_test/flutter_test.dart';
import 'package:refcue_app/firebase_login/authentication/models/models.dart';

void main() {
  group('FormTest', () {
    group('Form models validation tests', () {
      group('Email validation tests', () {
        test('', () {});
        test('Given name@mail.com validation should return null', () {
          var email = "name@mail.com";
          var model = Email.pure().validator(email);

          expect(model, null);
        });
        test(
            'Given name@mail validation should return invalid EmailValidationError',
            () {
          var email = "name@mail";
          var model = Email.pure().validator(email);

          expect(model, EmailValidationError.invalid);
        });
        test(
            'Given name@mail. validation should return invalid EmailValidationError',
            () {
          var email = "name@mail.";
          var model = Email.pure().validator(email);

          expect(model, EmailValidationError.invalid);
        });
      });

      group('Password validation tests', () {
        //Testing password without any capital letter and special mark
        test('Given password, validation should return PasswordValidationError',
            () {
          var password = "password";
          var model = Password.pure().validator(password);

          expect(model, PasswordValidationError.invalid);
        });
      });
    });
  });
}
