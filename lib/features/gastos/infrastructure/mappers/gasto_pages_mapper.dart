import 'package:spendit_test/features/gastos/infrastructure/mappers/mappers.dart';
import '../../domain/entities/entities.dart';

class GastoPagesMapper {
  static jsonToEntity(Map<String, dynamic> json) => GastoPages(
        content: List<Gasto>.from(
            json["content"].map((x) => GastoMapper.jsonToEntity(x))),
        pageable: Pageable.fromJson(json["pageable"]),
        last: json["last"],
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        size: json["size"],
        number: json["number"],
        sort: Sort.fromJson(json["sort"]),
        first: json["first"],
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
      );
}
