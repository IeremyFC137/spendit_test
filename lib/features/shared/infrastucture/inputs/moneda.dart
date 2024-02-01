import 'package:formz/formz.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';

// Define los errores de validación del tipo de documento
enum MoneyTypeError { empty, invalid }

class MoneyType extends FormzInput<Moneda, MoneyTypeError> {
  const MoneyType.pure() : super.pure(Moneda.SOLES);
  const MoneyType.dirty([Moneda value = Moneda.SOLES]) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (error) {
      case MoneyTypeError.empty:
        return 'El tipo de moneda no puede estar vacío';
      case MoneyTypeError.invalid:
        return 'Tipo de moneda inválido';
      default:
        return null;
    }
  }

  @override
  MoneyTypeError? validator(Moneda value) {
    if (value != Moneda.SOLES && value != Moneda.DOLARES)
      return MoneyTypeError.invalid;

    return null;
  }
}
