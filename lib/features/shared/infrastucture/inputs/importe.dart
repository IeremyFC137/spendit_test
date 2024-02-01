import 'package:formz/formz.dart';

// Define los errores de validación para el campo de tipo double.
enum ImporteInputdError { empty, invalid }

class Importe extends FormzInput<double, ImporteInputdError> {
  const Importe.pure() : super.pure(0.0);
  const Importe.dirty([double value = 0.0]) : super.dirty(value);

  String? get errorMessage {
    switch (error) {
      case ImporteInputdError.empty:
        return 'El campo "Importe" no puede ser nulo';
      default:
        return null;
    }
  }

  @override
  ImporteInputdError? validator(double value) {
    if (value == 0.0) {
      return ImporteInputdError.empty;
    }
    // Aquí se puede añadir más lógica de validación si es necesario
    return null;
  }
}
