import 'package:spendit_test/features/gastos/domain/domain.dart';

class ConsultaSunatMapper {
  static JsonToEntity(Map<String, dynamic> json) => ConsultaSunat(
      estado: json["success"] as bool,
      messaje: json["message"] as String,
      estadoCp: json["estadoCp"] as String,
      estadoRuc: json["estadoRuc"] as String,
      condDomiRuc: json["condDomiRuc"] as String,
      observaciones: json["observaciones"] as List<dynamic>?);
}
