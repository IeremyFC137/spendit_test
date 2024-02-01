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
  DateFormat formatoConGuiones = DateFormat("yyyy-MM-dd");
  DateFormat formatoConBarras = DateFormat("yyyy/MM/dd");

  try {
    // Primero intenta con el formato con guiones
    return formatoConGuiones.parseStrict(fechaStr);
  } catch (e) {
    try {
      // Si falla, intenta con el formato con barras
      return formatoConBarras.parseStrict(fechaStr);
    } catch (e) {
      // Si ambos fallan, lanza una excepción
      throw FormatException("Formato de fecha no válido: $fechaStr");
    }
  }
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
  return formatter.format(dateTime);
}
