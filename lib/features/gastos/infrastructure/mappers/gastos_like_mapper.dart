import 'package:spendit_test/features/gastos/domain/entities/entities.dart';

import '../../../shared/shared.dart';

class GastoLikeMapper {
  static gastoToGastoLikeEntity(Gasto gasto) => GastoLike(
      id: gasto.id,
      proveedor: gasto.proveedor,
      ruc: gasto.ruc,
      tipoDocumento: gasto.tipoDocumento,
      documento: gasto.documento,
      fechaEmision: gasto.fechaEmision,
      subTotal: gasto.subTotal,
      igv: gasto.igv,
      importe: gasto.importe,
      pImporte: gasto.pImporte,
      moneda: gasto.moneda,
      cCosto: gasto.cCosto,
      cGasto: gasto.cGasto,
      cContable: gasto.cContable,
      images: gasto.images);

  static scanitJsonToGastoLikeEntity(Map<String, dynamic> json) => GastoLike(
        proveedor: json["proveedor"],
        ruc: json["ruc"],
        tipoDocumento: parseTipoDocumento(json["tipo_documento"] as String)!,
        documento: json["documento"],
        fechaEmision: parseFechaEmision(json["fecha_emision"]),
        moneda: parseMoneda(json["moneda"] as String),
        subTotal: json["sub_total"],
        igv: json["igv"],
      );
}
