import 'package:expense_tracker/translation/app_translation.dart';
import 'package:expense_tracker/views/dashboard/binding/dashboard_binding.dart';
import 'package:expense_tracker/views/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/auth/login/login_view.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  final _settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      initState: (state) => SettingController(),
      builder: (context) {
        var isDark = _settingController.isDarkMode;
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker-ASS',
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          darkTheme: isDark ? ThemeData.dark() : ThemeData.light(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          initialBinding: DashboardBinding(),
          home: LoginPage(),
          translations: AppTranslation(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale('en', 'US'),
        );
      },
    );
  }
}
