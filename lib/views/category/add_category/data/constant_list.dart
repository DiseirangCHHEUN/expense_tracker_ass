import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List colorList = [
  {'value': '0xFFEC407A', 'color': const Color(0xFFEC407A)},
  {'value': '0xFF43A047', 'color': const Color(0xFF43A047)},
  {'value': '0xFF26C6DA', 'color': const Color(0xFF26C6DA)},
  {'value': '0xFF006064', 'color': const Color(0xFF006064)},
  {'value': '0xFF00ACC1', 'color': const Color(0xFF00ACC1)},
  {'value': '0xFF00838F', 'color': const Color(0xFF00838F)},
  {'value': '0xFFFF0256', 'color': const Color(0xFFFF0256)},
  {'value': '0xFF00FF0D', 'color': const Color(0xFF00FF0D)},
  {'value': '0xFFA1DBE2', 'color': const Color(0xFFA1DBE2)},
  {'value': '0xFFAD0000', 'color': const Color(0xFFAD0000)},
  {'value': '0xFFC10081', 'color': const Color(0xFFC10081)},
  {'value': '0xFF5B008F', 'color': const Color(0xFF5B008F)},
];

final List cateType = [
  {
    'name': 'Income',
    'icon': Icons.incomplete_circle_rounded,
  },
  {
    'name': 'Expense',
    'icon': Icons.open_in_browser_rounded,
  },
  {
    'name': 'Saving',
    'icon': Icons.savings_rounded,
  },
  {
    'name': 'Dept',
    'icon': Icons.departure_board_rounded,
  },
  {
    'name': 'Loan',
    'icon': FontAwesomeIcons.dollarSign,
  },
  {
    'name': 'Investment',
    'icon': Icons.bar_chart_rounded,
  },
  {
    'name': 'Others',
    'icon': Icons.more_rounded,
  },
];
