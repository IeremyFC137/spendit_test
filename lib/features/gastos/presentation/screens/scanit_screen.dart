import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:spendit_test/features/gastos/presentation/providers/providers.dart';

import '../../../shared/shared.dart';

class ScanitScreen extends ConsumerStatefulWidget {
  static const name = "scanit_screen";
  const ScanitScreen({super.key});

  @override
  _ScanitScreenState createState() => _ScanitScreenState();
}

class _ScanitScreenState extends ConsumerState<ScanitScreen> {
  File? _capturedImage;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    // Se abre la cámara directamente sin mostrar botón
    Future.microtask(() => takePhotoAndSend(context, ref));
  }

  Future<File?> compressFile(File file) async {
    File? compressedFile;
    int quality = 90;

    while (quality > 0) {
      final filePath = file.absolute.path;
      // Obtiene la extensión del archivo original para mantenerla
      final fileExtension = filePath.substring(filePath.lastIndexOf('.'));
      // Construye un nuevo nombre de archivo para el archivo comprimido
      final outPath =
          "${filePath.substring(0, filePath.lastIndexOf('.'))}_compressed_$quality$fileExtension";

      final XFile? result = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: quality,
      );

      if (result == null) break; // Si no se pudo comprimir, termina el bucle

      compressedFile = File(result.path); // Convierte XFile a File
      final fileSize = await compressedFile.length();

      if (fileSize <= 1024 * 1024) {
        break; // Si el tamaño es menor o igual a 1MB, termina el bucle
      } else {
        quality -= 5; // Reduce la calidad y repite el proceso
      }
    }

    return compressedFile;
  }

  Future<void> takePhotoAndSend(BuildContext context, WidgetRef ref) async {
    setState(() {
      _isProcessing = true; // Iniciar procesamiento
      _capturedImage = null; // Asegúrate de resetear la imagen capturada aquí
    });

    final photoPath = await CameraGalleryServiceImpl().takePhoto();
    if (photoPath != null) {
      final file = File(photoPath);
      setState(() {
        _capturedImage =
            file; // Muestra la imagen capturada mientras se procesa
      });
      final compressedFile = await compressFile(file);
      if (compressedFile != null) {
        final gastoLike = await ref
            .read(gastosProvider.notifier)
            .enviarImagen(compressedFile);
        setState(() {
          _isProcessing = false; // Procesamiento terminado
        });
        if (gastoLike?.proveedor != '' ||
            gastoLike?.ruc != '' ||
            gastoLike?.tipoDocumento != null ||
            gastoLike?.documento != '' ||
            gastoLike?.fechaEmision != null ||
            gastoLike?.moneda != null ||
            gastoLike?.subTotal != 0 ||
            gastoLike?.igv != 0) {
          GoRouter.of(context)
              .pushReplacement('/gastos/ingreso-manual', extra: gastoLike);
        } else {
          showError(
              "El documento escaneado no se ha reconocido como un comprobante de pago.");
        }
      } else {
        showError();
      }
    } else {
      setState(() {
        _isProcessing = false; // Cancelación o fallo al tomar foto
      });
    }
  }

  void showError([String? message]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message ?? "Error al enviar la imagen. Intente de nuevo."),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 6),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.inversePrimary.withAlpha(205).withOpacity(1),
      appBar: const AppBarWidget(title: "Scanit"),
      body: _isProcessing
          ? _capturedImage != null
              ? Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.file(
                          _capturedImage!), // Muestra la imagen capturada
                      FullScreenLoader() // Indicador de carga sobre la imagen
                    ],
                  ),
                )
              : FullScreenLoader()
          : Center(
              child: ElevatedButton.icon(
                icon: FaIcon(FontAwesomeIcons.robot),
                onPressed: () {
                  takePhotoAndSend(context, ref);
                },
                label: Text("Escanear"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ), // No muestra nada mientras no se esté procesando
    );
  }
}
