import 'package:dio/dio.dart';
import 'package:spendit_test/config/config.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/infrastructure/infrastructure.dart';

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
      double? pImporte}) {
    throw UnimplementedError();
  }

  @override
  Future<void> eliminarGasto(int gastoId) {
    throw UnimplementedError();
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
  Future<void> validarGastoConSunat() {
    // TODO: implement validarGastoConSunat
    throw UnimplementedError();
  }
}
