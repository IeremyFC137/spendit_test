import 'package:spendit_test/features/gastos/domain/domain.dart';

class Gasto {
  final int id;
  final int idUsuario;
  final String proveedor;
  final String ruc;
  final TipoDocumento tipoDocumento;
  final String documento;
  final DateTime fechaEmision;
  final double subTotal;
  final double igv;
  final double importe;
  final double pImporte;
  final Moneda moneda;
  final String cCosto;
  final String cGasto;
  final String cContable;
  final String estado;

  Gasto(
      {required this.id,
      required this.idUsuario,
      required this.proveedor,
      required this.ruc,
      required this.tipoDocumento,
      required this.documento,
      required this.fechaEmision,
      required this.subTotal,
      required this.igv,
      required this.importe,
      required this.pImporte,
      required this.moneda,
      required this.cCosto,
      required this.cGasto,
      required this.cContable,
      required this.estado});
}
