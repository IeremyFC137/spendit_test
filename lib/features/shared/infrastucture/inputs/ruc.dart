import 'package:formz/formz.dart';

// Define los errores de validación del RUC
enum RucError { empty, invalidFormat, invalidLength }

class Ruc extends FormzInput<String, RucError> {
  // Define un patrón para validar el RUC, esto dependerá de las reglas de negocio específicas
  // Por ejemplo, un RUC peruano tiene 11 dígitos y comienza con 10, 15, 17, 20
  static final RegExp rucRegExp = RegExp(
    r'^[1|2][0|5|7|0]\d{9}$',
  );

  const Ruc.pure() : super.pure('');

  const Ruc.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    if (error == RucError.empty) return 'El RUC no puede estar vacío';
    if (error == RucError.invalidLength) return 'El RUC debe tener 11 dígitos';
    if (error == RucError.invalidFormat) return 'Formato de RUC inválido';

    return null;
  }

  @override
  RucError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return RucError.empty;
    if (value.length != 11) return RucError.invalidLength;
    if (!rucRegExp.hasMatch(value)) return RucError.invalidFormat;

    return null;
  }
}
