import 'package:flutter/material.dart';
import '../models/calculator_model.dart';
import '../controllers/calculator_controller.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  late final CalculatorModel model;
  late final CalculatorController controller;

  @override
  void initState() {
    super.initState();
    model = CalculatorModel();
    controller = CalculatorController(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/history'),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                model.display,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          ..._buildButtons(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/converter'),
                child: const Text(
                  'KM to Miles',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/history'),
                child: const Text(
                  'View History',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  List<Widget> _buildButtons() {
    const buttonLabels = [
      ['7', '8', '9', '/'],
      ['4', '5', '6', '*'],
      ['1', '2', '3', '-'],
      ['C', '0', '=', '+'],
    ];

    return buttonLabels.map((row) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: row.map((label) {
          return ElevatedButton(
            onPressed: () => _onButtonPress(label),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              backgroundColor: _getButtonColor(label),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                color: _getTextColor(label),
              ),
            ),
          );
        }).toList(),
      );
    }).toList();
  }

  Color _getButtonColor(String label) {
    if (['+', '-', '*', '/'].contains(label)) {
      return Colors.orange;
    } else {
      return Colors.grey[800]!;
    }
  }

  Color _getTextColor(String label) {
    if (['+', '-', '*', '/', '=', 'C'].contains(label)) {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  void _onButtonPress(String label) {
    setState(() {
      if (double.tryParse(label) != null) {
        controller.onNumberPress(label);
      } else if (['+', '-', '*', '/'].contains(label)) {
        controller.onOperatorPress(label);
      } else if (label == '=') {
        controller.onEqualsPress();
      } else if (label == 'C') {
        controller.onClearPress();
      }
    });
  }
}
