import 'package:flutter/material.dart';
import '../vistas/screen_scanner.dart';
import '../vistas/screen_verificacion_alimentos.dart';

class QRScannerProvider with ChangeNotifier {
  void navigateToQRScanner(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRScannerScreen()),
    );
  }

  void navigateToVerificionScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const VerificionScreen()),
    );
  }
}