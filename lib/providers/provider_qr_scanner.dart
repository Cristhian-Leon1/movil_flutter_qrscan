import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerProvider with ChangeNotifier {
  void navigateToQRScanner(BuildContext context) {
    Navigator.pushNamed(context, '/scanner_screen');
  }

  void navigateToVerificionScreen(BuildContext context) {
    Navigator.pushNamed(context, '/verificacion_screen');
  }

  void handleQRCodeDetection(BuildContext context, BarcodeCapture barcodeCapture) async {
    final barcode = barcodeCapture.barcodes.first;
    if (barcode.rawValue != null) {
      final String code = barcode.rawValue!;
      final String encodedCode = code.replaceAll(' ', '%20');
      print('Código QR escaneado: $encodedCode');

      final response = await http.get(
        Uri.parse('https://aplicativocomidasqr.onrender.com/users/findByName?name=$encodedCode'),
      );
      if (response.statusCode == 200) {
        print('Respuesta del servidor: ${response.body}');
        final Map<String, dynamic> responseData = json.decode(response.body);
        bool hasPerroOhamburguesa = responseData.containsKey('perroOhamburguesa');
        print('Tiene perroOhamburguesa: $hasPerroOhamburguesa');
        if (context.mounted) {
          Navigator.popAndPushNamed(
            context,
            '/alimentos_screen',
            arguments: {
              'qrCode': code,
              'hasPerroOhamburguesa': hasPerroOhamburguesa,
              'responseData': responseData,
            },
          );
        }
      } else {
        print('Error en la petición: ${response.statusCode}');
      }
    }
  }

  Future<void> toggleAttribute(BuildContext context, String name, String attribute, bool currentState) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(currentState ? 'Desmarcar como entregado' : 'Marcar como entregado'),
          content: Text('¿Está seguro de que desea ${currentState ? 'desmarcar' : 'marcar'} este alimento como entregado?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );

    if (confirmation == true) {
      final response = await http.put(
        Uri.parse('https://aplicativocomidasqr.onrender.com/users/toggleAttribute'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'attribute': attribute}),
      );

      if (response.statusCode == 200) {
        print('Atributo actualizado correctamente');
        notifyListeners();
      } else {
        print('Error al actualizar el atributo: ${response.statusCode}');
      }
    }
  }
}