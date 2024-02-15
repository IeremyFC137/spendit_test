import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/shared/widgets/app_bar_widget.dart';

import '../../infrastructure/mappers/parse_qr_data.dart';

class QRScannerScreen extends StatefulWidget {
  static const name = "qr_scanner_screen";
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

// Extiende de StatefulWidget y mezcla con WidgetsBindingObserver
class _QRScannerScreenState extends State<QRScannerScreen>
    with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  // Registra el observador en initState
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  // Implementa didChangeAppLifecycleState para manejar la pausa y reanudación de la cámara
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // La app se ha reanudado, intenta reanudar la cámara
      controller?.resumeCamera();
    } else if (state == AppLifecycleState.paused) {
      // La app se ha pausado, intenta pausar la cámara
      controller?.pauseCamera();
    }
  }

  // Asegúrate de remover el observador en dispose
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Pausa la cámara antes de navegar
      controller.pauseCamera();
      final GastoLike? gastoLike = parseQRData(scanData.code ?? '');
      // Navega a la pantalla de ingreso manual con los datos del formulario
      GoRouter.of(context)
          .pushReplacement('/gastos/ingreso-manual', extra: gastoLike);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "Escanear código"),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
