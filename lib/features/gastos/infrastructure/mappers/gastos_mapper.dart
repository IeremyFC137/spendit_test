import 'package:spendit_test/features/gastos/domain/entities/entities.dart';
import '../../../shared/shared.dart';

class GastoMapper {
  static gastoJsonToEntity(Map<String, dynamic> json) => Gasto(
      id: json["id"],
      idUsuario: json["idUsuario"],
      proveedor: json["proveedor"],
      ruc: json["ruc"],
      tipoDocumento: parseTipoDocumento(json["tipo_documento"] as String)!,
      documento: json["documento"],
      fechaEmision: DateTime.parse(json["fecha_emision"]),
      subTotal: json["sub_total"],
      igv: json["igv"],
      importe: json["importe"],
      pImporte: json["p_importe"],
      moneda: parseMoneda(json["moneda"] as String)!,
      cCosto: json["c_costo"],
      cGasto: json["c_gasto"],
      cContable: json["c_contable"],
      estado: json["estado"],
      images: List<String>.from(json['imagenes'] ?? []));
}
