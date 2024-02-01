import 'package:spendit_test/features/gastos/domain/entities/entities.dart';
import 'mapper_utils.dart';

class GastoMapper {
  static gastoJsonToEntity(Map<String, dynamic> json) => Gasto(
      id: json["id"],
      idUsuario: json["idUsuario"],
      proveedor: json["proveedor"],
      ruc: json["ruc"],
      tipoDocumento: parseTipoDocumento(json["tipo_documento"] as String),
      documento: json["documento"],
      fechaEmision: DateTime.parse(json["fecha_emision"]),
      subTotal: double.parse(json["sub_total"].toString()),
      igv: double.parse(json["igv"].toString()),
      importe: double.parse(json["importe"].toString()),
      pImporte: double.parse(json["p_importe"].toString()),
      moneda: parseMoneda(json["moneda"] as String),
      cCosto: json["c_costo"],
      cGasto: json["c_gasto"],
      cContable: json["c_contable"],
      estado: json["estado"]);
}
