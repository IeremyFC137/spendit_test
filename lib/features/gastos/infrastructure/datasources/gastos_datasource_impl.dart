import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:spendit_test/config/config.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/infrastructure/infrastructure.dart';

import '../../../shared/shared.dart';

class GastosDatasourceImpl extends GastosDatasource {
  late final Dio dio;
  final String accessToken;

  GastosDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {'Authorization': 'Bearer $accessToken'}));

  @override
  Future<Gasto> editarGasto(
      {required int gastoId,
      String? cCosto,
      String? cGasto,
      String? cContable,
      double? importe,
      double? pImporte}) async {
    final Map<String, dynamic> data = {
      'id': gastoId,
    };
    if (cCosto != null) data['c_costo'] = cCosto;
    if (cGasto != null) data['c_gasto'] = cGasto;
    if (cContable != null) data['c_contable'] = cContable;
    if (importe != 0.0) data['importe'] = importe;
    if (pImporte != 2.0) data['p_importe'] = pImporte;
    try {
      final response = await dio.put("/gastos", data: data);
      final Gasto gasto = GastoMapper.gastoJsonToEntity(response.data);
      return gasto;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw GastoNotFound();
      }
      throw Exception();
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<void> eliminarGasto(int gastoId) async {
    await dio.delete("/gastos/${gastoId}");
  }

  @override
  Future<Gasto> getGastoById(int gastoId) async {
    try {
      final response = await dio.get("/gastos/${gastoId}");
      final Gasto gasto = GastoMapper.gastoJsonToEntity(response.data);
      return gasto;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        throw GastoNotFound();
      }
      throw Exception();
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<List<Gasto>> listarGastos({int size = 7, int page = 0}) async {
    final response = await dio.get("/gastos?size=$size&page=$page");
    final GastoPages mappedResponse =
        GastoPagesMapper.jsonToEntity(response.data);
    final List<Gasto> content = mappedResponse.content;

    return content;
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
      required String cContable}) async {
    final response = await dio.post("/gastos", data: {
      'idUsuario': idUsuario,
      'proveedor': proveedor,
      'ruc': ruc,
      'tipo_documento': tipoDocumento.name,
      'documento': documento,
      'fecha_emision': formatDateTime(fecha_emision),
      'sub_total': subTotal,
      'igv': igv,
      'importe': importe,
      'p_importe': pImporte,
      'moneda': moneda.name,
      'c_costo': cCosto,
      'c_gasto': cGasto,
      'c_contable': cContable
    });
    Gasto gasto = GastoMapper.gastoJsonToEntity(response.data);
    return gasto;
  }

  @override
  Future<GastoLike> enviarImagen(File imagen) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imagen.path, filename: "upload.jpg"),
    });

    final response = await dio.post("/scanit", data: formData);
    if (response.statusCode == 200) {
      // Asume que tienes una función que convierte json a GastoLike
      GastoLike gastoLike =
          GastoLikeMapper.scanitJsonToGastoLikeEntity(response.data);
      return gastoLike;
    } else {
      throw Exception('Error al enviar imagen');
    }
  }

  @override
  Future<ConsultaSunat> validarGastoConSunat(GastoLike gasto) async {
    final response = await dio.post("/sunat/validarComprobante", data: {
      "numRuc": gasto.ruc,
      "codComp": gasto.tipoDocumento == TipoDocumento.FACTURA ? "01" : "03",
      "numeroSerie": gasto.documento!.substring(0, 4),
      "numero": gasto.documento!.substring(5),
      "fechaEmision": DateFormat('dd/MM/yyyy').format(gasto.fechaEmision!),
      "monto": (gasto.igv! + gasto.subTotal!)
    });
    if (response.statusCode == 200) {
      ConsultaSunat data = ConsultaSunatMapper.JsonToEntity(response.data);
      return data;
    } else {
      throw Exception('Error al procesar los datos del comprobante');
    }
  }

  @override
  Future<List> obtenerCampoDetalle() async {
    final response = await dio.get("/gastos/obtenerCentroCosto");
    if (response.statusCode == 200) {
      List listaCcosto = response.data["datos"];
      return listaCcosto;
    } else {
      throw Exception('Error al obtener la lista de centro de costos');
    }
  }
}
