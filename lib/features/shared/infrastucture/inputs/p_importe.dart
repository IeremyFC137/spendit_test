import 'package:formz/formz.dart';

// Define los errores de validación para el campo de tipo double.
enum PimporteInputError { empty, invalid }

class Pimporte extends FormzInput<double, PimporteInputError> {
  const Pimporte.pure() : super.pure(0.0);
  const Pimporte.dirty(double value) : super.dirty(value);

  String? get errorMessage {
    if (error == PimporteInputError.empty)
      return 'El campo "Porcentaje de importe" no puede ser nulo';
    if (error == PimporteInputError.invalid)
      return 'El "Porcentaje de importe" debe estar entre 0 y 1';
    return null;
  }

  @override
  PimporteInputError? validator(double value) {
    if (value == 0.0) {
      return PimporteInputError.empty;
    }
    if (value > 1 || value < 0) {
      return PimporteInputError.invalid;
    }
    // Aquí se puede añadir más lógica de validación si es necesario
    return null;
  }
}
