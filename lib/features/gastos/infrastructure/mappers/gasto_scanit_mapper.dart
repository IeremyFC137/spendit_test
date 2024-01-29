import 'package:spendit_test/features/gastos/domain/entities/entities.dart';
import 'utils_mapper.dart';

class GastoScanitMapper {
  static jsonToEntity(Map<String, dynamic> json) => GastoScanit(
      proveedor: json["proveedor"],
      ruc: json["ruc"],
      tipoDocumento: parseTipoDocumento(json["tipo_documento"] as String),
      documento: json["documento"],
      fechaEmision: parseFechaEmision(json["fecha_emision"]),
      moneda: parseMoneda(json["moneda"] as String),
      subTotal: double.parse(json["sub_total"].toString()),
      igv: double.parse(json["igv"].toString()),
      total: double.parse(json["total"].toString()));
}
