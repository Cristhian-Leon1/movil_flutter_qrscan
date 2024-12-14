import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerProvider with ChangeNotifier {
  bool _isRequestInProgress = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void navigateToQRScanner(BuildContext context) {
    Navigator.pushNamed(context, '/scanner_screen');
  }

  Future<void> navigateToVerificionScreen(BuildContext context) async {
    setLoading(true);
    try {
      final response = await http.get(
        Uri.parse('https://aplicativocomidasqr.onrender.com/users/countFoodAvailability'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> foodAvailability = json.decode(response.body);

        if (context.mounted) {
          Navigator.pushNamed(
            context,
            '/verificacion_screen',
            arguments: {
              'foodAvailability': foodAvailability,
            },
          );
        }
      } else {
        print('Error en la petición: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la petición: $e');
    } finally {
      setLoading(false);
    }
  }

  void handleQRCodeDetection(BuildContext context, BarcodeCapture barcodeCapture) async {
    if (_isRequestInProgress) return;

    final barcode = barcodeCapture.barcodes.first;
    if (barcode.rawValue != null) {
      _isRequestInProgress = true;
      final String code = barcode.rawValue!;
      final String encodedCode = code.replaceAll(' ', '%20');
      print('Código QR escaneado: $encodedCode');

      try {
        final response = await http.get(
          Uri.parse('https://aplicativocomidasqr.onrender.com/users/findByName?name=$encodedCode'),
        );

        if (response.statusCode == 200) {
          print('Respuesta del servidor: ${response.body}');
          final Map<String, dynamic> responseData = json.decode(response.body);
          bool hasPerroOhamburguesa = responseData.containsKey('perroOhamburguesa1') && responseData['perroOhamburguesa1'] == true;
          bool showSecondAccordionItem = responseData.containsKey('perroOhamburguesa1') || responseData.containsKey('cerveza6');
          bool showSecondAccordionItem2 = responseData.containsKey('perroOhamburguesa2') || responseData.containsKey('cerveza10');
          bool hasPerroOhamburguesa2 = responseData.containsKey('perroOhamburguesa2');
          bool isNumRif666 = responseData['numRif'] == '666';
          print(isNumRif666);
          print('Tiene perroOhamburguesa: $hasPerroOhamburguesa');
          if (context.mounted) {
            Navigator.popAndPushNamed(
              context,
              '/alimentos_screen',
              arguments: {
                'qrCode': code,
                'hasPerroOhamburguesa': hasPerroOhamburguesa,
                'responseData': responseData,
                'showSecondAccordionItem': showSecondAccordionItem,
                'showSecondAccordionItem2': showSecondAccordionItem2,
                'hasPerroOhamburguesa2': hasPerroOhamburguesa2,
                'isNumRif666': isNumRif666,
              },
            );
          }
        } else {
          print('Error en la petición: ${response.statusCode}');
        }
      } catch (e) {
        print('Error en la petición: $e');
      } finally {
        _isRequestInProgress = false;
      }
    }
  }

  Future<void> toggleAttribute(BuildContext context, String name, String attribute, bool currentState) async {
    bool confirmation = true;

    if (attribute != 'asistencia') {
      confirmation = await showDialog<bool>(
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
      ) ?? false;
    }

    if (confirmation) {
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