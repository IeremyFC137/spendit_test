import 'package:formz/formz.dart';

// Define los errores de validación para el campo de tipo double.
enum IgvInputError { empty, invalid }

class Igv extends FormzInput<double, IgvInputError> {
  const Igv.pure() : super.pure(0.0);
  const Igv.dirty(double value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    switch (error) {
      case IgvInputError.empty:
        return 'El campo "Igv" no puede ser nulo';
      case IgvInputError.invalid:
        return 'El campo "Igv" no puede ser negativo';
      default:
        return null;
    }
  }

  @override
  IgvInputError? validator(double value) {
    if (value == 0.0) {
      return IgvInputError.empty;
    }
    if (value < 0) {
      return IgvInputError.invalid;
    }
    // Aquí se puede añadir más lógica de validación si es necesario
    return null;
  }
}
