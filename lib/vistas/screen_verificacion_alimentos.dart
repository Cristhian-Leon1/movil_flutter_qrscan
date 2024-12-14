import 'package:flutter/material.dart';
import 'screen_home.dart';

const Map<String, String> foodTitles = {
  'almuerzo': 'Cantidad de almuerzos:',
  'gaseosa': 'Cantidad de gaseosas:',
  'cerveza': 'Cantidad de cervezas:',
  'helado': 'Cantidad de helados:',
  'empanada': 'Cantidad de empanadas:',
  'postre': 'Cantidad de postres:',
  'perroOhamburguesa': 'Cantidad de perros/hamburguesas:',
};

const Map<String, Map<String, String>> foodWords = {
  'almuerzo': {'entregadas': 'entregados', 'porEntregar': 'por entregar'},
  'gaseosa': {'entregadas': 'entregadas', 'porEntregar': 'por entregar'},
  'cerveza': {'entregadas': 'entregadas', 'porEntregar': 'por entregar'},
  'helado': {'entregadas': 'entregados', 'porEntregar': 'por entregar'},
  'empanada': {'entregadas': 'entregadas', 'porEntregar': 'por entregar'},
  'postre': {'entregadas': 'entregados', 'porEntregar': 'por entregar'},
  'perroOhamburguesa': {'entregadas': 'entregados', 'porEntregar': 'por entregar'},
};

class VerificionScreen extends StatelessWidget {
  const VerificionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Map<String, dynamic> foodAvailability = arguments['foodAvailability'];

    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: BackgroundPainter(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: ListView.builder(
                itemCount: foodAvailability.length,
                itemBuilder: (context, index) {
                  String key = foodAvailability.keys.elementAt(index);
                  int entregadas = foodAvailability[key]['false'];
                  int porEntregar = foodAvailability[key]['true'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      color: Colors.white70,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: TextoCantidad(
                          title: foodTitles[key] ?? 'Cantidad de $key:',
                          entregadas: entregadas,
                          porEntregar: porEntregar,
                          entregadasLabel: foodWords[key]?['entregadas'] ?? 'entregadas',
                          porEntregarLabel: foodWords[key]?['porEntregar'] ?? 'por entregar',
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextoCantidad extends StatelessWidget {
  final String title;
  final int entregadas;
  final int porEntregar;
  final String entregadasLabel;
  final String porEntregarLabel;

  const TextoCantidad({
    super.key,
    required this.title,
    required this.entregadas,
    required this.porEntregar,
    required this.entregadasLabel,
    required this.porEntregarLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          '$entregadas $entregadasLabel',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          '$porEntregar $porEntregarLabel',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}