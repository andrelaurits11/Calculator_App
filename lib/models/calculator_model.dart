import 'package:intl/intl.dart';
import 'package:math_expressions/math_expressions.dart';
import '../database/history_database.dart';
import '../models/history_model.dart';

class CalculatorModel {
  String display = '0';
  String _equation = '';
  double? result;

  void appendNumber(String number) {

    if (display == '0' || (_equation.isNotEmpty && _equation.endsWith('='))) {
      display = number;
      _equation = number;
      display += number;
      _equation += number;
    }
  }

  void setOperator(String op) {
    if (_equation.isNotEmpty && !['+', '-', '*', '/'].contains(_equation[_equation.length - 1])) {
      _equation += ' $op';
      display = '';
    }
  }

  Future<void> calculate() async {
    if (_equation.isNotEmpty) {
      try {
        Expression exp = Parser().parse(_equation);
        result = exp.evaluate(EvaluationType.REAL, ContextModel());

        if (result != null) {
          display = result!.toStringAsFixed(2);

          final calculationString = '$_equation = ${display}';
          final timestamp = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
          final entry = HistoryEntry(calculation: calculationString, timestamp: timestamp);


          await HistoryDatabase.instance.insertHistory(entry);
        } else {
          display = 'Error';
        }
        _equation = '';
      } catch (e) {
        display = 'Error';
        _equation = '';
      }
    }
  }

  void clear() {
    display = '0';
    _equation = '';
    result = null;
  }
}
