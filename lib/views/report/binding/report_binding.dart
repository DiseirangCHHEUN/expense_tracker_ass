import 'package:expense_tracker/views/report/controller/report_controller.dart';
import 'package:get/get.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(
      () => ReportController(),
    );
  }
}
