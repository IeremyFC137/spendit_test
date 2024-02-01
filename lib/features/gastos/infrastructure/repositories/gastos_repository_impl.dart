import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/infrastructure/infrastructure.dart';

class GastosRepositoryImpl extends GastosRepository {
  final GastosDatasourceImpl datasource;

  GastosRepositoryImpl(this.datasource);

  @override
  Future<Gasto> editarGasto(
      {required int gastoId,
      String? cCosto,
      String? cGasto,
      String? cContable,
      double? importe,
      double? pImporte}) {
    return datasource.editarGasto(
        gastoId: gastoId,
        cCosto: cCosto,
        cContable: cContable,
        cGasto: cGasto,
        importe: importe,
        pImporte: pImporte);
  }

  @override
  Future<void> eliminarGasto(int gastoId) {
    return datasource.eliminarGasto(gastoId);
  }

  @override
  Future<Gasto> getGastoById(int gastoId) {
    return datasource.getGastoById(gastoId);
  }

  @override
  Future<List<Gasto>> listarGastos({int size = 7, int page = 0}) {
    return datasource.listarGastos(page: page, size: size);
  }

  @override
  Future<Gasto> registrarGasto(
      {required int idUsuario,
      required String proveedor,
      required String ruc,
      required TipoDocumento tipoDocumento,
      required String documento,
      required DateTime fecha_emision,
      required double subTotal,
      required double igv,
      required double importe,
      required double pImporte,
      required Moneda moneda,
      required String cCosto,
      required String cGasto,
      required String cContable}) {
    return datasource.registrarGasto(
        idUsuario: idUsuario,
        proveedor: proveedor,
        ruc: ruc,
        tipoDocumento: tipoDocumento,
        documento: documento,
        fecha_emision: fecha_emision,
        subTotal: subTotal,
        igv: igv,
        importe: importe,
        pImporte: pImporte,
        moneda: moneda,
        cCosto: cCosto,
        cGasto: cGasto,
        cContable: cContable);
  }

  @override
  Future<void> validarGastoConSunat() {
    // TODO: implement validarGastoConSunat
    throw UnimplementedError();
  }
}
