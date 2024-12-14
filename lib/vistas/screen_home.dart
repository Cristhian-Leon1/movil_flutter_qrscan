import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movil_flutter_qrscan/vistas/widgets/boton_personalizable.dart';
import 'package:provider/provider.dart';
import 'package:movil_flutter_qrscan/providers/provider_qr_scanner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final isLoading = context.watch<QRScannerProvider>().isLoading;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: BackgroundPainter(),
            ),
            Center(
              child: SizedBox(
                width: width * 0.85,
                child: Card(
                  color: Colors.white70,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const Icon(
                          Icons.qr_code_scanner,
                          size: 170,
                          color: Colors.black54,
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Monitoreo de alimentos por QR',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BotonPersonalizable(
                          text: 'Escanear codigo QR',
                          color: Colors.white38,
                          onPressed: () {
                            Provider.of<QRScannerProvider>(context, listen: false).navigateToQRScanner(context);
                          },
                        ),
                        const SizedBox(height: 20),
                        isLoading
                            ? const CircularProgressIndicator(color: Colors.blue)
                            : BotonPersonalizable(
                          text: 'Verificar cantidad de alimentos',
                          color: Colors.white38,
                          onPressed: () {
                            Provider.of<QRScannerProvider>(context, listen: false).navigateToVerificionScreen(context);
                          },
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    final paintYellow = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final paintBlue = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final paintRed = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCircle(center: Offset(size.width * 0.2, size.height * 0.15), radius: 50),
      paintYellow,
    );

    canvas.drawOval(
      Rect.fromCircle(center: Offset(size.width * 0.8, size.height * 0.22), radius: 70),
      paintBlue,
    );

    canvas.drawOval(
      Rect.fromCircle(center: Offset(size.width * 0.25, size.height * 0.8), radius: 60),
      paintRed,
    );

    canvas.drawOval(
      Rect.fromCircle(center: Offset(size.width * 0.6, size.height * 0.9), radius: 40),
      paintYellow,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
