import 'package:flutter/material.dart';
import 'package:calculator_app/view/calculator_view.dart';
import 'package:calculator_app/view/ km_to_miles_converter_view.dart';
import 'package:calculator_app/view/history_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator with Converter & History',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: const CalculatorView(),
      routes: {
        '/converter': (context) => const KmToMilesConverterView(),
        '/history': (context) => const HistoryView(),
      },
    );
  }
}
