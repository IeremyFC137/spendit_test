import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

// Define los errores de validación
enum FechaEmisionInputError { empty, futureDate, invalidFormat }

class FechaEmision extends FormzInput<String, FechaEmisionInputError> {
  const FechaEmision.pure() : super.pure('');
  const FechaEmision.dirty(String value) : super.dirty(value);

  @override
  FechaEmisionInputError? validator(String value) {
    if (value.isEmpty) {
      return FechaEmisionInputError
          .empty; // Considera si una fecha vacía es aceptable
    }

    try {
      final dateFormat =
          DateFormat('yyyy-MM-dd'); // Ajusta el formato según sea necesario
      final dateTime = dateFormat.parseStrict(value);

      if (dateTime.isAfter(DateTime.now())) {
        return FechaEmisionInputError.futureDate;
      }
    } catch (e) {
      return FechaEmisionInputError.invalidFormat;
    }

    return null;
  }

  String? get errorMessage {
    switch (error) {
      case FechaEmisionInputError.futureDate:
        return 'La fecha no puede estar en el futuro';
      case FechaEmisionInputError.invalidFormat:
        return 'Formato de fecha inválido';
      case FechaEmisionInputError.empty:
        return 'El campo "Fecha de Emisión" no puede ser nulo';
      default:
        return null;
    }
  }
}
