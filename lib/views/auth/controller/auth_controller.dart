// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  // text editing controller for login page
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController pwdLoginController = TextEditingController();

  // text editing controller for signup page
  final TextEditingController usernameSignupController =
      TextEditingController();
  final TextEditingController emailSignupController = TextEditingController();
  final TextEditingController phoneSignupController = TextEditingController();
  final TextEditingController pwdSignupController = TextEditingController();
  final TextEditingController cPwdSignupController = TextEditingController();

  bool isPwdVisibility = true;
  void toggleShowPwd() {
    isPwdVisibility = !isPwdVisibility;
    print(isPwdVisibility);
    update();
  }

  // For pick image or take a photo
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickGalleryImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void clearLoginData() {
    emailLoginController.clear();
    pwdLoginController.clear();
  }

  void clearSignupData() {
    usernameSignupController.clear();
    emailSignupController.clear();
    phoneSignupController.clear();
    pwdSignupController.clear();
    cPwdSignupController.clear();
  }
}
