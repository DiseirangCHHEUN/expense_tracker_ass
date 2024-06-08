import 'package:expense_tracker/views/report/controller/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Report'),
      ),
    );
  }
}
