import 'package:spendit_test/features/gastos/domain/entities/gasto.dart';

import 'pageable.dart';
import 'sort.dart';

class GastoPages {
  final List<Gasto> content;
  final Pageable pageable;
  final bool last;
  final int totalPages;
  final int totalElements;
  final int size;
  final int number;
  final Sort sort;
  final bool first;
  final int numberOfElements;
  final bool empty;

  GastoPages(
      {required this.content,
      required this.pageable,
      required this.last,
      required this.totalPages,
      required this.totalElements,
      required this.size,
      required this.number,
      required this.sort,
      required this.first,
      required this.numberOfElements,
      required this.empty});
}
