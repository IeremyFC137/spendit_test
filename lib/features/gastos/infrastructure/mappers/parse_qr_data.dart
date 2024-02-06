Map<String, dynamic> parseQRData(String qrData) {
  // Dividir el string por el delimitador '|'
  List<String> parts = qrData.split('|');

  if (parts.length >= 9) {
    // Asignar cada parte a la variable correspondiente,
    // asegurándose de que el formato y los tipos de datos sean correctos
    String ruc = parts[0];
    String documento =
        '${parts[1]}-${parts[2]}'; // Concatenar tipo y número de documento
    double igv = double.tryParse(parts[4]) ??
        0.0; // Convertir a double, con fallback a 0.0
    double total = double.tryParse(parts[5]) ?? 0.0; // Ídem
    DateTime fechaEmision =
        DateTime.tryParse(parts[6].split('.').reversed.join('-')) ??
            DateTime.now(); // Asumiendo formato dd.mm.aaaa
    // La moneda y otros campos no están claros en el string de ejemplo,
    // pero puedes añadirlos aquí si están disponibles o necesarios

    // Crear y devolver el mapa con los datos
    return {
      "ruc": ruc,
      "documento": documento,
      "igv": igv,
      "total": total,
      "fechaEmision": fechaEmision,
      // Añadir más campos según sea necesario
    };
  } else {
    // Manejar error o string inesperado
    throw FormatException('El formato del QR no es válido.');
  }
}
