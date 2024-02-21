import 'package:spendit_test/features/gastos/domain/entities/entities.dart';
import '../../../shared/shared.dart';
import 'gasto_detalles_mapper.dart';

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
      moneda: parseMoneda(json["moneda"] as String)!,
      detalles: (json["detalles"] as List)
          .map((detalleJson) =>
              GastoDetallesMapper.gastoDetalleJsonToEntity(detalleJson))
          .cast<DetallesGasto>()
          .toList(),
      estado: json["estado"],
      images: List<String>.from(json['imagenes'] ?? []));
}
