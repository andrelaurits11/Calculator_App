import 'package:flutter/material.dart';
import '../models/history_model.dart';
import '../database/history_database.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late Future<List<HistoryEntry>> _historyEntries;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() {
    _historyEntries = HistoryDatabase.instance.getHistory();
  }

  Future<void> _clearHistory() async {
    await HistoryDatabase.instance.clearHistory();
    setState(() {
      _loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Taust must
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.black, // AppBar taust must
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _clearHistory,
            tooltip: 'Clear History',
            color: Colors.white, // Nupu ikoon valge
          ),
        ],
      ),
      body: FutureBuilder<List<HistoryEntry>>(
        future: _historyEntries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No history found.', style: TextStyle(color: Colors.white)));
          }

          final history = snapshot.data!;
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final entry = history[index];
              return ListTile(
                title: Text(
                  entry.calculation,
                  style: const TextStyle(color: Colors.white), // Tekst valge
                ),
                subtitle: Text(
                  entry.timestamp,
                  style: const TextStyle(color: Colors.white), // Tekst valge
                ),
              );
            },
          );
        },
      ),
    );
  }
}
