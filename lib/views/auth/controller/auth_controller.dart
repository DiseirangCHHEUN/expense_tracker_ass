import 'dart:io';

import 'package:expense_tracker/views/auth/login/login_view.dart';
import 'package:expense_tracker/views/dashboard/dashboard_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  var email = ''.obs;
  var password = ''.obs;
  var currentPassword = ''.obs;
  var confirmPassword = ''.obs;
  var phoneNumber = ''.obs;
  var isPwdVisibility = true.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      // User is not logged in
      clearData();
      Get.offAll(() => LoginPage());
    } else {
      // User is logged in
      Get.offAll(() => DashboardView());
    }
  }

  void clearData() {
    email.value = '';
    password.value = '';
    currentPassword.value = '';
    confirmPassword.value = '';
    phoneNumber.value = '';
    imageFile = null; // Reset imageFile as well
    update(); // Notify listeners about data changes
  }

  void register(String email, String password, String currentPassword,
      String phoneNumber) async {
    if (password != currentPassword) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful registration, clear data and navigate to login page
      clearData();
      Get.offAll(() => LoginPage());
    } catch (e) {
      Get.snackbar(
        "Error creating account",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // After successful login, clear data and navigate to home page
      clearData();
      Get.offAll(() => DashboardView());
    } catch (e) {
      Get.snackbar(
        "Error logging in",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Password Reset",
        "Password reset email has been sent to $email",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error resetting password",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void resetPasswordByPhoneNumber(String phoneNumber) async {
    try {
      // Implement your custom logic to reset password via phone number
      await Future.delayed(Duration(seconds: 2)); // Simulating a delay

      Get.snackbar(
        "Reset Password",
        "Password reset via phone number is not supported in this demo.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error resetting password",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    await auth.signOut();
    // Clear data upon sign out
    clearData();
    // Navigate back to login page
    Get.offAll(() => LoginPage());
  }

  void toggleShowPwd() {
    isPwdVisibility.value = !isPwdVisibility.value;
  }

  Future<void> pickGalleryImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      CroppedFile? croppedFiled = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
        ],
      );
      if (croppedFiled != null) {
        imageFile = File(croppedFiled.path);
        update();
      }
    }
  }
}
