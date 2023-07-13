import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_payments/screens/certification.dart';
import 'package:flutter_payments/screens/certification_result.dart';
import 'package:flutter_payments/screens/certification_test.dart';
import 'package:flutter_payments/screens/home.dart';
import 'package:flutter_payments/screens/payment.dart';
import 'package:flutter_payments/screens/payment_result.dart';
import 'package:flutter_payments/screens/payment_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const Color primaryColor = Color(0xff344e81);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return MaterialApp(
      title: 'Flutter Payment',
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/payment-test': (context) => const PaymentTest(),
        '/payment': (context) => const Payment(),
        '/payment-result': (context) => const PaymentResult(),
        '/certification-test': (context) => const CertificationTest(),
        '/certification': (context) => const Certification(),
        '/certification-result': (constext) => const CertificationResult(),
      },
    );
  }
}
