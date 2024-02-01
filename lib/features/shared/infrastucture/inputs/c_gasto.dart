import 'package:formz/formz.dart';

// Definir los errores de validación para el campo proveedor
enum ConceptoGastoError { empty }

// Extender FormzInput y proporcionar el tipo de input y el tipo de error.
class ConceptoGasto extends FormzInput<String, ConceptoGastoError> {
  // Constructor para estado inicial puro
  const ConceptoGasto.pure() : super.pure('');

  // Constructor para estado modificado
  const ConceptoGasto.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    switch (error) {
      case ConceptoGastoError.empty:
        return 'El campo "Concepto de gasto" no puede estar vacio';
      default:
        return null;
    }
  }

  // Sobreescritura del método validator para manejar la validación del valor del input
  @override
  ConceptoGastoError? validator(String value) {
    return value.trim().isEmpty ? ConceptoGastoError.empty : null;
  }
}
