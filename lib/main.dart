import 'package:expense_tracker/views/auth/controller/auth_controller.dart';
import 'package:expense_tracker/views/testtwo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => LoginPage()),
      //   GetPage(name: '/home', page: () => DashboardView()),
      // ],
      home: HomeScreentwo(),
    );
  }
}
