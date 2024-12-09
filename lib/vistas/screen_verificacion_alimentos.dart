import 'package:flutter/material.dart';
import 'package:movil_flutter_qrscan/vistas/widgets/textos_cantidad.dart';
import 'screen_home.dart';

class VerificionScreen extends StatelessWidget {
  const VerificionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: BackgroundPainter(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.white70,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: TextoCantidad(
                      title: 'Cantidad de comidas:',
                      entregadas: 10,
                      porEntregar: 5,
                    ),
                  ),
                ),
                const SizedBox(height: 140),
                Card(
                  color: Colors.white70,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: TextoCantidad(
                      title: 'Cantidad de bebidas:',
                      entregadas: 30,
                      porEntregar: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}