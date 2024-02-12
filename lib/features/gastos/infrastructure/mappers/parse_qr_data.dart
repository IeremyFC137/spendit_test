import 'package:intl/intl.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';

GastoLike? parseQRData(String qrData) {
  // Dividir el string por el delimitador '|'
  List<String> parts = qrData.split('|');

  if (parts.length >= 9) {
    DateTime fechaOriginal =
        DateTime.tryParse(parts[6].split('.').reversed.join('-')) ??
            DateTime.now();
    String ruc = parts[0];
    TipoDocumento? tipoDocumento = parts[1] == "01"
        ? TipoDocumento.FACTURA
        : parts[1] == "02"
            ? TipoDocumento.BOLETA
            : null;
    String documento = '${parts[2]}-${parts[3]}';
    double igv = double.tryParse(parts[4]) ?? 0.0;
    double total = double.tryParse(parts[5]) ?? 0.0;
    DateTime fechaEmision =
        DateTime.parse(DateFormat('yyyy-MM-dd').format(fechaOriginal));

    return GastoLike(
        ruc: ruc,
        tipoDocumento: tipoDocumento,
        documento: documento,
        igv: igv,
        subTotal: total - igv,
        fechaEmision: fechaEmision);
  } else {
    // Manejar error o string inesperado
    return null;
  }
}
