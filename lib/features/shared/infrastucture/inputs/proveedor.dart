import 'package:formz/formz.dart';

// Definir los errores de validación para el campo proveedor
enum ProveedorError { empty }

// Extender FormzInput y proporcionar el tipo de input y el tipo de error.
class Proveedor extends FormzInput<String, ProveedorError> {
  // Constructor para estado inicial puro
  const Proveedor.pure() : super.pure('');

  // Constructor para estado modificado
  const Proveedor.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    switch (error) {
      case ProveedorError.empty:
        return 'El campo "proveedor" no puede estar vacio';
      default:
        return null;
    }
  }

  // Sobreescritura del método validator para manejar la validación del valor del input
  @override
  ProveedorError? validator(String value) {
    if (value.trim().isEmpty) {
      return ProveedorError.empty;
    }
    if (value.trim().isEmpty) {
      return ProveedorError.empty;
    }
    return null;
  }
}
