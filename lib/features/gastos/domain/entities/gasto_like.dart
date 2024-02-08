import 'package:spendit_test/features/gastos/domain/domain.dart';

class GastoLike {
  final int? id;
  final String? proveedor;
  final String? ruc;
  final TipoDocumento? tipoDocumento;
  final String? documento;
  final DateTime? fechaEmision;
  final double? subTotal;
  final double? igv;
  final double? importe;
  final double? pImporte;
  final Moneda? moneda;
  final String? cCosto;
  final String? cGasto;
  final String? cContable;
  final List<String>? images;

  GastoLike(
      {this.id,
      this.proveedor,
      this.ruc,
      this.tipoDocumento,
      this.documento,
      this.fechaEmision,
      this.subTotal,
      this.igv,
      this.importe,
      this.pImporte,
      this.moneda,
      this.cCosto,
      this.cGasto,
      this.cContable,
      this.images});
  @override
  String toString() {
    // TODO: implement toString
    return """
      GastosLike
      -----------
        id: ${this.id}
        proveedor: ${this.proveedor}
        ruc: ${this.ruc}
        tipo_documento: ${this.tipoDocumento?.name}
        documento: ${this.documento}
        fechaEmision: ${this.fechaEmision}
        subTotal: ${this.subTotal}
        igv: ${this.igv}
        importe: ${this.importe}
        pImporte: ${this.pImporte}
        moneda: ${this.moneda?.name}
        cCosto: ${this.cCosto}
        cGasto ${this.cGasto}
        cContable: ${this.cContable}
        images: ${this.images}
""";
  }
}
