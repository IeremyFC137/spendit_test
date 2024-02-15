class ConsultaSunat {
  final bool estado;
  final String messaje;
  final String estadoCp;
  final String estadoRuc;
  final String condDomiRuc;
  final List<dynamic>? observaciones;
  ConsultaSunat(
      {required this.estado,
      required this.messaje,
      required this.estadoCp,
      required this.estadoRuc,
      required this.condDomiRuc,
      this.observaciones});
}
