// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingController extends GetxController {
  @override
  void onInit() {
    loadSettingsData();
    super.onInit();
  }

  late Locale local;
  bool isNotificationOn = false;
  bool isEnglish = false;
  bool isDarkMode = false;
  toggleLanguage() async {
    if (Get.locale == const Locale('km', 'KH')) {
      local = const Locale('en', 'US');
      isEnglish = !isEnglish;
      await Get.updateLocale(local);
      updateEnglishLang();
      return;
    }

    if (Get.locale == const Locale('en', 'US')) {
      local = const Locale('km', 'KH');
      isEnglish = !isEnglish;
      await Get.updateLocale(local);
      updateEnglishLang();
      return;
    }
  }

  void changeLanguage() async {
    if (isEnglish) {
      local = const Locale('en', 'US');
      await Get.updateLocale(local);
      updateEnglishLang();
      return;
    } else {
      local = const Locale('km', 'KH');
      await Get.updateLocale(local);
      updateEnglishLang();
      return;
    }
  }

  void changeToEngLang() async {
    isEnglish = false;
    local = const Locale('en', 'US');
    await Get.updateLocale(local);
    updateEnglishLang();
    Get.back();
    return;
  }

  void changeToKhmerLang() async {
    isEnglish = true;
    local = const Locale('km', 'KH');
    await Get.updateLocale(local);
    updateEnglishLang();
    Get.back();
    return;
  }

  void toDark() {
    isDarkMode = true;
    update();
    updateThemeMode();
    Get.back();
  }

  void tolight() {
    isDarkMode = false;
    update();
    updateThemeMode();
    Get.back();
  }

  final isEnglishBox = Hive.box('english');
  final isNotificationBox = Hive.box('notification');
  final isDarkThemeBox = Hive.box('thememode');

  void loadSettingsData() async {
    if (isEnglishBox.get('ENGLISH') != null) {
      isEnglish = await isEnglishBox.get('ENGLISH');
      changeLanguage();
      update();
    }

    if (isNotificationBox.get('NOTIFICATION') != null) {
      isNotificationOn = await isNotificationBox.get('NOTIFICATION');
      update();
    }
    if (isDarkThemeBox.get('THEMEMODE') != null) {
      isDarkMode = await isDarkThemeBox.get('THEMEMODE');
      print(isDarkMode);
      update();
    }
  }

  void updateEnglishLang() {
    isEnglishBox.put('ENGLISH', isEnglish);
  }

  void updateNotification() {
    isNotificationBox.put('NOTIFICATION', isNotificationOn);
  }

  void updateThemeMode() {
    isDarkThemeBox.put('THEMEMODE', isDarkMode);
  }

  void toggleNotification() {
    isNotificationOn = !isNotificationOn;
    updateNotification();
    update();
  }
}
