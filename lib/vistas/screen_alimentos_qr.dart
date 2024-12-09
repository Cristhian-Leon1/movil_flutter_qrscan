import 'package:flutter/material.dart';
import 'package:movil_flutter_qrscan/vistas/screen_home.dart';
import 'package:accordion/accordion.dart';
import 'package:provider/provider.dart';
import 'package:movil_flutter_qrscan/providers/provider_qr_scanner.dart';

class AlimentosScreen extends StatefulWidget {
  final String qrCode;
  final bool hasPerroOhamburguesa;
  final Map<String, dynamic> responseData;

  const AlimentosScreen({
    super.key,
    required this.qrCode,
    required this.hasPerroOhamburguesa,
    required this.responseData,
  });

  @override
  _AlimentosScreenState createState() => _AlimentosScreenState();
}

class _AlimentosScreenState extends State<AlimentosScreen> {
  late bool hasPerroOhamburguesa;
  late Map<String, dynamic> responseData;

  @override
  void initState() {
    super.initState();
    hasPerroOhamburguesa = widget.hasPerroOhamburguesa;
    responseData = widget.responseData;
  }

  @override
  void didUpdateWidget(covariant AlimentosScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hasPerroOhamburguesa != widget.hasPerroOhamburguesa) {
      setState(() {
        hasPerroOhamburguesa = widget.hasPerroOhamburguesa;
      });
    }
  }

  void toggleAttribute(String attribute) async {
    bool currentState = responseData[attribute];
    await Provider.of<QRScannerProvider>(context, listen: false)
        .toggleAttribute(context, widget.qrCode, attribute, currentState);
    setState(() {
      responseData[attribute] = !currentState;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              size: Size.infinite,
              painter: BackgroundPainter(),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Center(
                  child: Column(
                    children: [
                      const Card(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        elevation: 5,
                        color: Colors.white70,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Pulse sobre cada tarjeta de alimento para marcar como alimento entregado',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Accordion(
                        maxOpenSections: 1,
                        headerBackgroundColor: Colors.deepPurple,
                        headerPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        children: [
                          AccordionSection(
                            isOpen: true,
                            header: Text(widget.qrCode,
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            headerBackgroundColor: Colors.deepPurple,
                            contentBorderColor: Colors.deepPurple,
                            contentBackgroundColor: Colors.transparent,
                            content: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 13.0,
                                mainAxisSpacing: 13.0,
                              ),
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                String title;
                                IconData icon;
                                bool isDelivered;
                                String attribute;

                                switch (index) {
                                  case 0:
                                    title = 'Almuerzo';
                                    icon = Icons.restaurant;
                                    isDelivered = responseData['almuerzo2'];
                                    attribute = 'almuerzo2';
                                    break;
                                  case 1:
                                    title = 'Cerveza 3';
                                    icon = Icons.local_drink;
                                    isDelivered = responseData['cerveza3'];
                                    attribute = 'cerveza3';
                                    break;
                                  case 2:
                                    title = 'Cerveza 4';
                                    icon = Icons.local_drink;
                                    isDelivered = responseData['cerveza4'];
                                    attribute = 'cerveza4';
                                    break;
                                  case 3:
                                    title = 'Helado';
                                    icon = Icons.icecream;
                                    isDelivered = responseData['helado2'];
                                    attribute = 'helado2';
                                    break;
                                  case 4:
                                    title = 'Empanada';
                                    icon = Icons.fastfood;
                                    isDelivered = responseData['empanada2'];
                                    attribute = 'empanada2';
                                    break;
                                  case 5:
                                    title = 'Postre';
                                    icon = Icons.cake;
                                    isDelivered = responseData['postre2'];
                                    attribute = 'postre2';
                                    break;
                                  default:
                                    title = 'Otro';
                                    icon = Icons.local_dining;
                                    isDelivered = false;
                                    attribute = '';
                                }

                                return GestureDetector(
                                  onTap: () {
                                    toggleAttribute(attribute);
                                  },
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        color: Colors.white70,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(icon, size: 40, color: Colors.deepPurple),
                                              const SizedBox(height: 10),
                                              Text(
                                                title,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (!isDelivered)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: Container(
                                            color: Colors.red.withOpacity(0.5),
                                            child: const Center(
                                              child: Icon(Icons.close, size: 60, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          AccordionSection(
                            isOpen: true,
                            header: Text('Acompañante (${hasPerroOhamburguesa ? 'niño' : 'adulto'})',
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            headerBackgroundColor: Colors.deepPurple,
                            contentBorderColor: Colors.deepPurple,
                            content: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 13.0,
                                mainAxisSpacing: 13.0,
                              ),
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                String title;
                                IconData icon;
                                bool isDelivered;
                                String attribute;

                                if (hasPerroOhamburguesa) {
                                  switch (index) {
                                    case 0:
                                      title = 'Perro o hamburguesa';
                                      icon = Icons.fastfood;
                                      isDelivered = responseData['perroOhamburguesa'];
                                      attribute = 'perroOhamburguesa';
                                      break;
                                    case 1:
                                      title = 'Gaseosa';
                                      icon = Icons.local_drink;
                                      isDelivered = responseData['gaseosa1'];
                                      attribute = 'gaseosa1';
                                      break;
                                    case 2:
                                      title = 'Helado';
                                      icon = Icons.icecream;
                                      isDelivered = responseData['helado2'];
                                      attribute = 'helado2';
                                      break;
                                    case 3:
                                      title = 'Empanada';
                                      icon = Icons.fastfood;
                                      isDelivered = responseData['empanada2'];
                                      attribute = 'empanada2';
                                      break;
                                    case 4:
                                      title = 'Postre';
                                      icon = Icons.cake;
                                      isDelivered = responseData['postre2'];
                                      attribute = 'postre2';
                                      break;
                                    default:
                                      title = 'Otro';
                                      icon = Icons.local_dining;
                                      isDelivered = false;
                                      attribute = '';
                                  }
                                } else {
                                  switch (index) {
                                    case 0:
                                      title = 'Almuerzo';
                                      icon = Icons.restaurant;
                                      isDelivered = responseData['almuerzo2'];
                                      attribute = 'almuerzo2';
                                      break;
                                    case 1:
                                      title = 'Cerveza 3';
                                      icon = Icons.local_drink;
                                      isDelivered = responseData['cerveza3'];
                                      attribute = 'cerveza3';
                                      break;
                                    case 2:
                                      title = 'Cerveza 4';
                                      icon = Icons.local_drink;
                                      isDelivered = responseData['cerveza4'];
                                      attribute = 'cerveza4';
                                      break;
                                    case 3:
                                      title = 'Helado';
                                      icon = Icons.icecream;
                                      isDelivered = responseData['helado2'];
                                      attribute = 'helado2';
                                      break;
                                    case 4:
                                      title = 'Empanada';
                                      icon = Icons.fastfood;
                                      isDelivered = responseData['empanada2'];
                                      attribute = 'empanada2';
                                      break;
                                    case 5:
                                      title = 'Postre';
                                      icon = Icons.cake;
                                      isDelivered = responseData['postre2'];
                                      attribute = 'postre2';
                                      break;
                                    default:
                                      title = 'Otro';
                                      icon = Icons.local_dining;
                                      isDelivered = false;
                                      attribute = '';
                                  }
                                }

                                return GestureDetector(
                                  onTap: () {
                                    toggleAttribute(attribute);
                                  },
                                  child: Stack(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        color: Colors.white70,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(icon, size: 40, color: Colors.deepPurple),
                                              const SizedBox(height: 10),
                                              Text(
                                                title,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (!isDelivered)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: Container(
                                            color: Colors.red.withOpacity(0.5),
                                            child: const Center(
                                              child: Icon(Icons.close, size: 60, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ],
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