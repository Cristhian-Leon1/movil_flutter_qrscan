import 'package:flutter/material.dart';
import 'package:movil_flutter_qrscan/vistas/screen_home.dart';
import 'package:accordion/accordion.dart';
import 'package:movil_flutter_qrscan/vistas/widgets/card_alimentos.dart';
import 'package:provider/provider.dart';
import 'package:movil_flutter_qrscan/providers/provider_qr_scanner.dart';

class AlimentosScreen extends StatefulWidget {
  final String qrCode;
  final bool hasPerroOhamburguesa;
  final bool hasPerroOhamburguesa2;
  final bool showSecondAccordionItem;
  final bool showSecondAccordionItem2;
  final Map<String, dynamic> responseData;
  final bool isNumRif666;

  const AlimentosScreen({
    super.key,
    required this.qrCode,
    required this.hasPerroOhamburguesa,
    required this.responseData,
    required this.showSecondAccordionItem,
    required this.showSecondAccordionItem2,
    required this.hasPerroOhamburguesa2,
    required this.isNumRif666,
  });

  @override
  _AlimentosScreenState createState() => _AlimentosScreenState();
}

class _AlimentosScreenState extends State<AlimentosScreen> {
  late bool hasPerroOhamburguesa;
  late Map<String, dynamic> responseData;
  late bool showSecondAccordionItem;
  late bool showSecondAccordionItem2;
  late bool hasPerroOhamburguesa2;

  @override
  void initState() {
    super.initState();
    hasPerroOhamburguesa = widget.hasPerroOhamburguesa;
    responseData = widget.responseData;
    showSecondAccordionItem = widget.showSecondAccordionItem;
    showSecondAccordionItem2 = widget.showSecondAccordionItem2;
    hasPerroOhamburguesa2 = widget.hasPerroOhamburguesa2;
  }

  @override
  void didUpdateWidget(covariant AlimentosScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hasPerroOhamburguesa != widget.hasPerroOhamburguesa) {
      setState(() {
        hasPerroOhamburguesa = widget.hasPerroOhamburguesa;
      });
    }
    if (oldWidget.hasPerroOhamburguesa2 != widget.hasPerroOhamburguesa2) {
      setState(() {
        hasPerroOhamburguesa2 = widget.hasPerroOhamburguesa2;
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
              child: Column(
                children: [
                  const Card(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                    elevation: 5,
                    color: Colors.white70,
                    child: Padding(
                      padding: EdgeInsets.all(30),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Center(
                      child: Column(
                        children: [
                          if (!widget.isNumRif666) ...[
                            const SizedBox(height: 16),
                            Card(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              elevation: 5,
                              color: Colors.white70,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      'Número de rifa',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      responseData['numRif'].toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Card(
                              margin: const EdgeInsets.only(left: 10, right: 10),
                              elevation: 5,
                              color: Colors.white70,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      'Asistencia',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Estado:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Switch(
                                          value: responseData['asistencia'] ?? false,
                                          onChanged: (bool newValue) async {
                                            await Provider.of<QRScannerProvider>(context, listen: false)
                                                .toggleAttribute(context, widget.qrCode, 'asistencia', responseData['asistencia']);
                                            setState(() {
                                              responseData['asistencia'] = newValue;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
                                  itemCount: 9,
                                  itemBuilder: (context, index) {
                                    String title;
                                    IconData icon;
                                    bool isDelivered;
                                    String attribute;
                  
                                    switch (index) {
                                      case 0:
                                        title = 'Almuerzo';
                                        icon = Icons.restaurant;
                                        isDelivered = responseData['almuerzo1'];
                                        attribute = 'almuerzo1';
                                        break;
                                      case 1:
                                        title = 'Gaseosa';
                                        icon = Icons.local_drink_rounded;
                                        isDelivered = responseData['gaseosa1'];
                                        attribute = 'almuerzo1';
                                        break;
                                      case 2:
                                        title = 'Cerveza';
                                        icon = Icons.local_drink;
                                        isDelivered = responseData['cerveza1'];
                                        attribute = 'cerveza1';
                                        break;
                                      case 3:
                                        title = 'Cerveza';
                                        icon = Icons.local_drink;
                                        isDelivered = responseData['cerveza2'];
                                        attribute = 'cerveza2';
                                        break;
                                      case 4:
                                        title = 'Cerveza';
                                        icon = Icons.local_drink;
                                        isDelivered = responseData['cerveza3'];
                                        attribute = 'cerveza3';
                                        break;
                                      case 5:
                                        title = 'Cerveza';
                                        icon = Icons.local_drink;
                                        isDelivered = responseData['cerveza4'];
                                        attribute = 'cerveza4';
                                        break;
                                      case 6:
                                        title = 'Helado';
                                        icon = Icons.icecream;
                                        isDelivered = responseData['helado1'];
                                        attribute = 'helado1';
                                        break;
                                      case 7:
                                        title = 'Empanada';
                                        icon = Icons.fastfood;
                                        isDelivered = responseData['empanada1'];
                                        attribute = 'empanada1';
                                        break;
                                      case 8:
                                        title = 'Postre';
                                        icon = Icons.cake;
                                        isDelivered = responseData['postre1'];
                                        attribute = 'postre1';
                                        break;
                                      default:
                                        return const SizedBox.shrink();
                                    }
                  
                                    return GestureDetector(
                                      onTap: () {
                                        toggleAttribute(attribute);
                                      },
                                      child: CardAlimento(
                                        title: title,
                                        icon: icon,
                                        isDelivered: isDelivered,
                                        onTap: () {
                                          toggleAttribute(attribute);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              if (showSecondAccordionItem)
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
                                    itemCount: hasPerroOhamburguesa ? 5 : 9,
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
                                            isDelivered = responseData['perroOhamburguesa1'];
                                            attribute = 'perroOhamburguesa1';
                                            break;
                                          case 1:
                                            title = 'Gaseosa';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['gaseosa2'];
                                            attribute = 'gaseosa2';
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
                                            return const SizedBox.shrink();
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
                                            title = 'Gaseosa';
                                            icon = Icons.local_drink_rounded;
                                            isDelivered = responseData['gaseosa2'];
                                            attribute = 'almuerzo2';
                                            break;
                                          case 2:
                                            title = 'Cerveza';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['cerveza5'];
                                            attribute = 'cerveza5';
                                            break;
                                          case 3:
                                            title = 'Cerveza';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['cerveza6'];
                                            attribute = 'cerveza6';
                                            break;
                                          case 4:
                                            title = 'Cerveza';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['cerveza7'];
                                            attribute = 'cerveza7';
                                            break;
                                          case 5:
                                            title = 'Cerveza';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['cerveza8'];
                                            attribute = 'cerveza8';
                                            break;
                                          case 6:
                                            title = 'Helado';
                                            icon = Icons.icecream;
                                            isDelivered = responseData['helado2'];
                                            attribute = 'helado2';
                                            break;
                                          case 7:
                                            title = 'Empanada';
                                            icon = Icons.fastfood;
                                            isDelivered = responseData['empanada2'];
                                            attribute = 'empanada2';
                                            break;
                                          case 8:
                                            title = 'Postre';
                                            icon = Icons.cake;
                                            isDelivered = responseData['postre2'];
                                            attribute = 'postre2';
                                            break;
                                          default:
                                            return const SizedBox.shrink();
                                        }
                                      }
                  
                                      return GestureDetector(
                                        onTap: () {
                                          toggleAttribute(attribute);
                                        },
                                          child: CardAlimento(
                                            title: title,
                                            icon: icon,
                                            isDelivered: isDelivered,
                                            onTap: () {
                                              toggleAttribute(attribute);
                                            },
                                          ),
                                      );
                                    },
                                  ),
                                ),
                              if (showSecondAccordionItem2)
                                AccordionSection(
                                  isOpen: true,
                                  header: Text('Acompañante (${hasPerroOhamburguesa2 ? 'niño' : 'adulto'})',
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
                                    itemCount: hasPerroOhamburguesa2 ? 5 : 9,
                                    itemBuilder: (context, index) {
                                      String title;
                                      IconData icon;
                                      bool isDelivered;
                                      String attribute;
                  
                                      if (hasPerroOhamburguesa2) {
                                        switch (index) {
                                          case 0:
                                            title = 'Perro o hamburguesa';
                                            icon = Icons.fastfood;
                                            isDelivered = responseData['perroOhamburguesa2'];
                                            attribute = 'perroOhamburguesa2';
                                            break;
                                          case 1:
                                            title = 'Gaseosa';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['gaseosa3'];
                                            attribute = 'gaseosa3';
                                            break;
                                          case 2:
                                            title = 'Helado';
                                            icon = Icons.icecream;
                                            isDelivered = responseData['helado3'];
                                            attribute = 'helado3';
                                            break;
                                          case 3:
                                            title = 'Empanada';
                                            icon = Icons.fastfood;
                                            isDelivered = responseData['empanada3'];
                                            attribute = 'empanada3';
                                            break;
                                          case 4:
                                            title = 'Postre';
                                            icon = Icons.cake;
                                            isDelivered = responseData['postre3'];
                                            attribute = 'postre3';
                                            break;
                                          default:
                                            return const SizedBox.shrink();
                                        }
                                      } else {
                                        switch (index) {
                                          case 0:
                                            title = 'Almuerzo';
                                            icon = Icons.restaurant;
                                            isDelivered = responseData['almuerzo3'];
                                            attribute = 'almuerzo3';
                                            break;
                                          case 1:
                                            title = 'Gaseosa';
                                            icon = Icons.local_drink_rounded;
                                            isDelivered = responseData['gaseosa3'];
                                            attribute = 'almuerzo3';
                                            break;
                                          case 2:
                                            title = 'Cerveza';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['cerveza9'];
                                            attribute = 'cerveza9';
                                            break;
                                          case 3:
                                            title = 'Cerveza';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['cerveza10'];
                                            attribute = 'cerveza10';
                                            break;
                                          case 4:
                                            title = 'Cerveza';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['cerveza11'];
                                            attribute = 'cerveza11';
                                            break;
                                          case 5:
                                            title = 'Cerveza';
                                            icon = Icons.local_drink;
                                            isDelivered = responseData['cerveza12'];
                                            attribute = 'cerveza12';
                                            break;
                                          case 6:
                                            title = 'Helado';
                                            icon = Icons.icecream;
                                            isDelivered = responseData['helado3'];
                                            attribute = 'helado3';
                                            break;
                                          case 7:
                                            title = 'Empanada';
                                            icon = Icons.fastfood;
                                            isDelivered = responseData['empanada3'];
                                            attribute = 'empanada3';
                                            break;
                                          case 8:
                                            title = 'Postre';
                                            icon = Icons.cake;
                                            isDelivered = responseData['postre3'];
                                            attribute = 'postre3';
                                            break;
                                          default:
                                            return const SizedBox.shrink();
                                        }
                                      }
                  
                                      return GestureDetector(
                                        onTap: () {
                                          toggleAttribute(attribute);
                                        },
                                        child: CardAlimento(
                                          title: title,
                                          icon: icon,
                                          isDelivered: isDelivered,
                                          onTap: () {
                                            toggleAttribute(attribute);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}