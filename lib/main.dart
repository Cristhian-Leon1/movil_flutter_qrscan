import 'package:flutter/material.dart';
import 'package:movil_flutter_qrscan/vistas/screen_alimentos_qr.dart';
import 'package:provider/provider.dart';
import 'package:movil_flutter_qrscan/vistas/screen_home.dart';
import 'package:movil_flutter_qrscan/providers/provider_qr_scanner.dart';
import 'package:movil_flutter_qrscan/vistas/screen_scanner.dart';
import 'package:movil_flutter_qrscan/vistas/screen_verificacion_alimentos.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QRScannerProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/home_screen',
        routes: {
          '/home_screen': (context) => const HomeScreen(),
          '/scanner_screen': (context) => const QRScannerScreen(),
          '/verificacion_screen': (context) => const VerificionScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/alimentos_screen') {
            final args = settings.arguments as Map<String, dynamic>;
            final qrCode = args['qrCode'] as String;
            final hasPerroOhamburguesa = args['hasPerroOhamburguesa'] as bool;
            final responseData = args['responseData'] as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => AlimentosScreen(
                qrCode: qrCode,
                hasPerroOhamburguesa: hasPerroOhamburguesa,
                responseData: responseData,
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
