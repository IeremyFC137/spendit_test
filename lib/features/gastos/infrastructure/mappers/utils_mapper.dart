import 'package:intl/intl.dart';
import '../../domain/entities/entities.dart';

TipoDocumento parseTipoDocumento(String tipo) {
  switch (tipo.toUpperCase()) {
    case 'FACTURA':
      return TipoDocumento.FACTURA;
    case 'BOLETA':
      return TipoDocumento.BOLETA;
    default:
      throw Exception('Tipo de documento desconocido: $tipo');
  }
}

Moneda parseMoneda(String moneda) {
  switch (moneda.toUpperCase()) {
    case 'SOLES':
      return Moneda.SOLES;
    case 'DOLARES':
      return Moneda.DOLARES;
    default:
      throw Exception('Tipo de documento desconocido: $moneda');
  }
}

DateTime parseFechaEmision(String fechaStr) {
  DateFormat formato1 = DateFormat("dd/MM/yyyy");
  DateFormat formato2 = DateFormat("dd-MM-yyyy");
  try {
    return formato1.parse(fechaStr);
  } catch (e) {
    try {
      return formato2.parse(fechaStr);
    } catch (e) {
      throw FormatException("Formato de fecha no válido: $fechaStr");
    }
  }
}
