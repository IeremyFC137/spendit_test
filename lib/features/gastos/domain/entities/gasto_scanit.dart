import 'package:spendit_test/features/gastos/domain/domain.dart';

class GastoScanit {
  final String proveedor;
  final String ruc;
  final TipoDocumento tipoDocumento;
  final String documento;
  final DateTime fechaEmision;
  final Moneda moneda;
  final double subTotal;
  final double igv;
  final double total;

  GastoScanit(
      {required this.proveedor,
      required this.ruc,
      required this.tipoDocumento,
      required this.documento,
      required this.fechaEmision,
      required this.moneda,
      required this.subTotal,
      required this.igv,
      required this.total});
}
