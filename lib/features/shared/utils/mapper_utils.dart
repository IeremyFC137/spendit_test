import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../gastos/domain/domain.dart';
import '../infrastucture/inputs/inputs.dart';

TipoDocumento? parseTipoDocumento(String? tipo) {
  switch (tipo?.toUpperCase()) {
    case 'FACTURA':
      return TipoDocumento.FACTURA;
    case 'BOLETA':
      return TipoDocumento.BOLETA;
    default:
      return null;
  }
}

Moneda? parseMoneda(String? moneda) {
  switch (moneda?.toUpperCase()) {
    case 'SOLES':
      return Moneda.SOLES;
    case 'DOLARES':
      return Moneda.DOLARES;
    default:
      return null;
  }
}

DateTime? parseFechaEmision(String fechaStr) {
  // Lista de formatos a intentar
  List<DateFormat> formatos = [
    DateFormat("yyyy-MM-dd"),
    DateFormat("yyyy/MM/dd"),
    DateFormat("dd/MM/yyyy"),
    DateFormat("dd-MM-yyyy"),
  ];

  for (DateFormat formato in formatos) {
    try {
      // Intenta parsear la fecha con el formato actual
      return formato.parseStrict(fechaStr);
    } catch (e) {
      print(e);
    }
  }
  // Si ninguno de los formatos fue exitoso, retorna null
  return null;
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
  return formatter.format(dateTime);
}

List<DropdownMenuItem<TipoDocumento>> getTipoDocumentoItems() {
  return TipoDocumento.values.map((TipoDocumento tipo) {
    return DropdownMenuItem<TipoDocumento>(
      value: tipo,
      child: Text(tipo.name),
    );
  }).toList();
}

List<DropdownMenuItem<Moneda>> getMonedaItems() {
  return Moneda.values.map((Moneda tipo) {
    return DropdownMenuItem<Moneda>(
      value: tipo,
      child: Text(tipo.name),
    );
  }).toList();
}

TipoDocumento? parseStringToDocumentType(String input) {
  TipoDocumento tipo;

  switch (input) {
    case "BOLETA":
      tipo = TipoDocumento.BOLETA;
      break;
    case "FACTURA":
      tipo = TipoDocumento.FACTURA;
      break;
    default:
      // Manejo de un valor no esperado, podrías lanzar una excepción o manejarlo de otra manera
      return null;
  }

  return DocumentType.dirty(tipo).value;
}

Moneda? parseStringToMoneda(String input) {
  Moneda? tipo;

  switch (input) {
    case "SOLES":
      tipo = Moneda.SOLES;
      break;
    case "DOLARES":
      tipo = Moneda.DOLARES;
      break;
    default:
      // Manejo de un valor no esperado, podrías lanzar una excepción o manejarlo de otra manera
      return null;
  }

  return MoneyType.dirty(tipo).value;
}
