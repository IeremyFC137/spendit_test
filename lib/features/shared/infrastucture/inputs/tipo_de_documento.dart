import 'package:formz/formz.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';

// Define los errores de validación del tipo de documento
enum DocumentTypeError { empty, invalid }

class DocumentType extends FormzInput<TipoDocumento, DocumentTypeError> {
  const DocumentType.pure() : super.pure(TipoDocumento.BOLETA);
  const DocumentType.dirty([TipoDocumento value = TipoDocumento.BOLETA])
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (error) {
      case DocumentTypeError.empty:
        return 'El tipo de documento no puede estar vacío';
      case DocumentTypeError.invalid:
        return 'Tipo de documento inválido';
      default:
        return null;
    }
  }

  @override
  DocumentTypeError? validator(TipoDocumento value) {
    if (value != TipoDocumento.BOLETA && value != TipoDocumento.FACTURA)
      return DocumentTypeError.invalid;

    return null;
  }
}
