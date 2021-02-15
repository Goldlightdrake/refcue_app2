import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([String value = '']) : super.dirty(value);

  static final RegExp _nameRegExp = RegExp(
      r"^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$",
      caseSensitive: false);

  @override
  NameValidationError validator(String value) {
    return _nameRegExp.hasMatch(value) ? null : NameValidationError.invalid;
  }
}
