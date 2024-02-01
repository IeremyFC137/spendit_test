import 'package:formz/formz.dart';

// Define los errores de validación para el campo de tipo double.
enum SubTotalInputError { empty, invalid }

class SubTotal extends FormzInput<double, SubTotalInputError> {
  const SubTotal.pure() : super.pure(0.0);
  const SubTotal.dirty([double value = 0.0]) : super.dirty(value);

  String? get errorMessage {
    if (error == SubTotalInputError.empty)
      return 'El campo "Sub total" no puede ser nulo';

    return null;
  }

  @override
  SubTotalInputError? validator(double value) {
    if (value.isNaN || value == 0.0) {
      return SubTotalInputError.empty;
    }
    // Aquí se puede añadir más lógica de validación si es necesario
    return null;
  }
}
