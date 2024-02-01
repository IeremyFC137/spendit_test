import 'package:formz/formz.dart';

// Definir los errores de validación para el campo proveedor
enum CuentaContableError { empty }

// Extender FormzInput y proporcionar el tipo de input y el tipo de error.
class CuentaContable extends FormzInput<String, CuentaContableError> {
  // Constructor para estado inicial puro
  const CuentaContable.pure() : super.pure('');

  // Constructor para estado modificado
  const CuentaContable.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    switch (error) {
      case CuentaContableError.empty:
        return 'El campo "Cuenta contable" no puede estar vacio';
      default:
        return null;
    }
  }

  // Sobreescritura del método validator para manejar la validación del valor del input
  @override
  CuentaContableError? validator(String value) {
    return value.trim().isEmpty ? CuentaContableError.empty : null;
  }
}
