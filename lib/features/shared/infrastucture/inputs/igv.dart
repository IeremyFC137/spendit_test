import 'package:formz/formz.dart';

// Define los errores de validación para el campo de tipo double.
enum IgvInputError { empty, invalid }

class Igv extends FormzInput<double, IgvInputError> {
  const Igv.pure() : super.pure(0.0);
  const Igv.dirty(double value) : super.dirty(value);

  String? get errorMessage {
    switch (error) {
      case IgvInputError.empty:
        return 'El campo "Igv" no puede ser nulo';
      default:
        return null;
    }
  }

  @override
  IgvInputError? validator(double value) {
    if (value == 0.0) {
      return IgvInputError.empty;
    }
    // Aquí se puede añadir más lógica de validación si es necesario
    return null;
  }
}
