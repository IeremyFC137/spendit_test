import 'dart:io';

import '../entities/entities.dart';

abstract class GastosDatasource {
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
      required String cContable});

  Future<void> eliminarGasto(int gastoId);

  Future<Gasto> getGastoById(int gastoId);

  Future<Gasto> editarGasto(
      {required int gastoId,
      String? cCosto,
      String? cGasto,
      String? cContable,
      double? importe,
      double? pImporte});

  Future<List<Gasto>> listarGastos({int size = 7, int page = 0});

  Future<GastoLike> enviarImagen(File imagen);

  Future<ConsultaSunat> validarGastoConSunat(GastoLike gasto);
}
