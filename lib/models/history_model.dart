class HistoryEntry {
  final int? id;
  final String calculation;
  final String timestamp;

  HistoryEntry({this.id, required this.calculation, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {'id': id, 'calculation': calculation, 'timestamp': timestamp};
  }

  factory HistoryEntry.fromMap(Map<String, dynamic> map) {
    return HistoryEntry(
      id: map['id'],
      calculation: map['calculation'],
      timestamp: map['timestamp'],
    );
  }
}
