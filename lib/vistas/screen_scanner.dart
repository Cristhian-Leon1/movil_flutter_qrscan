import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'screen_home.dart';
import 'package:movil_flutter_qrscan/providers/provider_qr_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: BackgroundPainter(),
            ),
            Center(
              child: Card(
                color: Colors.white70,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: height * 0.45,
                    width: width * 0.85,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: MobileScanner(
                        fit: BoxFit.cover,
                        onDetect: (barcodeCapture) {
                          Provider.of<QRScannerProvider>(context, listen: false)
                              .handleQRCodeDetection(context, barcodeCapture);
                        },
                      ),
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