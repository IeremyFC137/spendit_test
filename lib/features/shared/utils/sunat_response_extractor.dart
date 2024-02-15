String obtenerResultado(String resultado) {
  switch (resultado) {
    case "0":
      return "NO EXISTE";
    case "1":
      return "ACEPTADO";
    case "2":
      return "ANULADO";
    case "3":
      return "AUTORIZADO";
    case "4":
      return "NO AUTORIZADO";
    default:
      return "";
  }
}

String obtenerEstado(String estado) {
  switch (estado) {
    case "00":
      return "ACTIVO";
    case "01":
      return "BAJA PROVISIONAL";
    case "02":
      return "BAJA PROVISIONAL POR OFICIO";
    case "03":
      return "SUSPENSION TEMPORAL";
    case "10":
      return "BAJA DEFINITIVA";
    case "11":
      return "BAJA DE OFICIO";
    case "22":
      return "INHABILITADO-VENTA UNICA";
    default:
      return "";
  }
}

String obtenerCondicion(String condicion) {
  switch (condicion) {
    case "00":
      return "HABIDO";
    case "09":
      return "PENDIENTE";
    case "11":
      return "POR VERIFICAR";
    case "12":
      return "NO HABIDO";
    case "20":
      return "NO HALLADO";
    default:
      return "";
  }
}
