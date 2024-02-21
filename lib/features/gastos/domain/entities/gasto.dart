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
  final Moneda moneda;
  final List<DetallesGasto> detalles;
  final String estado;
  List<String> images;
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
      required this.moneda,
      required this.detalles,
      required this.estado,
      required this.images});
}
