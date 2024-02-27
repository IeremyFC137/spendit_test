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
      required Moneda moneda,
      required List<DetallesGasto> detalles});

  Future<void> eliminarGasto(int gastoId);

  Future<void> eliminarDetalleGasto(int detalleId);

  Future<Gasto> getGastoById(int gastoId);

  Future<Gasto> editarGasto(
      {required int gastoId,
      required List<DetallesGasto> detalles,
      List<int>? idsEliminar});

  Future<List<Gasto>> listarGastos({int size = 7, int page = 0});

  Future<GastoLike> enviarImagen(File imagen);

  Future<List> obtenerCampoDetalle();

  Future<ConsultaSunat> validarGastoConSunat(GastoLike gasto);
}
