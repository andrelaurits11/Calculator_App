import '../models/calculator_model.dart';

class CalculatorController {
  final CalculatorModel model;

  CalculatorController(this.model);

  void onNumberPress(String number) {
    model.appendNumber(number);
  }

  void onOperatorPress(String operator) {
    model.setOperator(operator);
  }

  Future<void> onEqualsPress() async {
    await model.calculate();
  }

  void onClearPress() {
    model.clear();
  }
}
