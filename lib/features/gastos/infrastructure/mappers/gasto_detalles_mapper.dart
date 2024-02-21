import 'package:spendit_test/features/gastos/domain/entities/entities.dart';

class GastoDetallesMapper {
  static gastoDetalleJsonToEntity(Map<String, dynamic> json) => DetallesGasto(
      id: json["id"],
      cCosto: json["c_costo"],
      cGasto: json["c_gasto"],
      cContable: json["c_contable"],
      importe: json["importe"],
      pImporte: json["p_importe"]);
}
