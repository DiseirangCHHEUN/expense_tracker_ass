import 'package:expense_tracker/constants/style_constant.dart';
import 'package:expense_tracker/translation/app_translation.dart';
import 'package:expense_tracker/views/dashboard/binding/dashboard_binding.dart';
import 'package:expense_tracker/views/dashboard/dashboard_view.dart';
import 'package:expense_tracker/views/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  final _settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      initState: (state) => SettingController(),
      builder: (context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          themeMode: ThemeMode.dark,
          darkTheme: darkThemeData,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[900],
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialBinding: DashboardBinding(),
          home: DashboardView(),
          translations: AppTranslation(),
          locale: _settingController.isEnglish
              ? const Locale('km', 'KH')
              : const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
        );
      },
    );
  }
}
