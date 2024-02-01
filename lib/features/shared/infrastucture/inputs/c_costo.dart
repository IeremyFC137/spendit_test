import 'package:formz/formz.dart';

// Definir los errores de validación para el campo proveedor
enum CentroCostoError { empty }

// Extender FormzInput y proporcionar el tipo de input y el tipo de error.
class CentroCosto extends FormzInput<String, CentroCostoError> {
  // Constructor para estado inicial puro
  const CentroCosto.pure() : super.pure('');

  // Constructor para estado modificado
  const CentroCosto.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    switch (error) {
      case CentroCostoError.empty:
        return 'El campo "Centro de costo" no puede estar vacio';
      default:
        return null;
    }
  }

  // Sobreescritura del método validator para manejar la validación del valor del input
  @override
  CentroCostoError? validator(String value) {
    if (value.trim().isEmpty) {
      return CentroCostoError.empty;
    }
    return null;
  }
}
