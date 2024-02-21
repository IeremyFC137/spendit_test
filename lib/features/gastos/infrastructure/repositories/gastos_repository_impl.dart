import 'dart:io';

import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/infrastructure/infrastructure.dart';

class GastosRepositoryImpl extends GastosRepository {
  final GastosDatasourceImpl datasource;

  GastosRepositoryImpl(this.datasource);

  @override
  Future<Gasto> editarGasto(
      {required int gastoId, required List<DetallesGasto> detalles}) {
    return datasource.editarGasto(gastoId: gastoId, detalles: detalles);
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
      required Moneda moneda,
      required List<DetallesGasto> detalles}) {
    return datasource.registrarGasto(
        idUsuario: idUsuario,
        proveedor: proveedor,
        ruc: ruc,
        tipoDocumento: tipoDocumento,
        documento: documento,
        fecha_emision: fecha_emision,
        subTotal: subTotal,
        igv: igv,
        moneda: moneda,
        detalles: detalles);
  }

  @override
  Future<GastoLike> enviarImagen(File imagen) {
    return datasource.enviarImagen(imagen);
  }

  @override
  Future<ConsultaSunat> validarGastoConSunat(GastoLike gasto) {
    return datasource.validarGastoConSunat(gasto);
  }

  @override
  Future<List> obtenerCampoDetalle() {
    return datasource.obtenerCampoDetalle();
  }
}
