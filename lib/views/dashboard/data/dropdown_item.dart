import 'package:flutter/material.dart';

enum ExpensionType {
  school('school', Colors.blue),
  dravel('dravel', Colors.pink),
  food('food', Colors.green),
  material('material', Colors.orange),
  waterFee('water fee', Colors.grey);

  const ExpensionType(this.label, this.color);
  final String label;
  final Color color;
}
