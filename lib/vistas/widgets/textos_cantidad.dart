import 'package:flutter/material.dart';

class TextoCantidad extends StatelessWidget {
  final String title;
  final int entregadas;
  final int porEntregar;

  const TextoCantidad({
    super.key,
    required this.title,
    required this.entregadas,
    required this.porEntregar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          'Entregadas: $entregadas',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          'Por entregar: $porEntregar',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}