import 'package:formz/formz.dart';

// Define los errores de validación del número de documento
enum DocumentNumberError { empty, invalidFormat }

class DocumentNumber extends FormzInput<String, DocumentNumberError> {
  // La expresión regular para validar la serie de boleta o factura.
  static final RegExp documentNumberRegExp = RegExp(
    r'\b([FfBbEeRr]\d{3}-\d{3,10}|\d{1,5}-\d{5,10})\b',
  );

  const DocumentNumber.pure() : super.pure('');

  const DocumentNumber.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;
    switch (error) {
      case DocumentNumberError.empty:
        return 'El número de documento no puede estar vacío';
      case DocumentNumberError.invalidFormat:
        return 'Número de documento inválido';
      default:
        return null;
    }
  }

  @override
  DocumentNumberError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DocumentNumberError.empty;
    if (!documentNumberRegExp.hasMatch(value))
      return DocumentNumberError.invalidFormat;

    return null;
  }
}
