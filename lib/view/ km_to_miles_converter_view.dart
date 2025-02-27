import 'package:flutter/material.dart';

class KmToMilesConverterView extends StatefulWidget {
  const KmToMilesConverterView({super.key});

  @override
  State<KmToMilesConverterView> createState() => _KmToMilesConverterViewState();
}

class _KmToMilesConverterViewState extends State<KmToMilesConverterView> {
  final TextEditingController _kmController = TextEditingController();
  String _result = '';

  void _convertKmToMiles() {
    final km = double.tryParse(_kmController.text);
    if (km != null) {
      final miles = km * 0.621371;
      setState(() => _result = '${miles.toStringAsFixed(2)} miles');
    } else {
      setState(() => _result = 'Invalid input');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Taust must
      appBar: AppBar(
        title: const Text('KM to Miles Converter'),
        backgroundColor: Colors.black, // AppBar taust must
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _kmController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter kilometers',
                labelStyle: TextStyle(color: Colors.white), // Tekst valge
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Fookuses oleva inputi piir mustaks
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Tavaline piir valge
                ),
              ),
              style: const TextStyle(color: Colors.white), // Teksti värv valge
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertKmToMiles,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, // Nuppude taust oranž
              ),
              child: const Text('Convert', style: TextStyle(fontSize: 20, color: Colors.white)), // Tekst nuppul valge
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Tekst valge
              ),
            ),
          ],
        ),
      ),
    );
  }
}
