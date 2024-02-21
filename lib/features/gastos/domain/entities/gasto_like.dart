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
  final Moneda? moneda;
  final List<DetallesGasto>? detalles;
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
      this.moneda,
      this.detalles,
      this.images});
  @override
  String toString() {
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
        moneda: ${this.moneda?.name}
        detalles: ${this.detalles?.map((e) => """
          id: ${e.id}
          c_costo: ${e.cCosto}
          c_gasto: ${e.cGasto}
          c_contable: ${e.cContable}
          importe: ${e.importe}
          p_importe: ${e.pImporte}
        """)}
        images: ${this.images}
""";
  }
}
