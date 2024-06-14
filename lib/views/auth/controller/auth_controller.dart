// ignore_for_file: avoid_print
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
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

  // For pick image or take a photo for profile
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickGalleryImage() async {
    // pick an image to crop
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // crop image for profile
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
              // CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              // CropAspectRatioPreset.ratio4x3,
              // CropAspectRatioPresetCustom(),
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              // CropAspectRatioPreset.original,
              // CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
              // CropAspectRatioPresetCustom(),
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

  // controller for reset password

  final frmKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  String email = '';
  bool isVisible = false;
  int? countDownNumber;
  Future<void> startPwdResetCountDown() async {
    if (countDownNumber == 0) {
      email = textEditingController.text;
      update();
      if (frmKey.currentState!.validate()) {
        for (int i = 59; i >= 0; i--) {
          textEditingController.clear();
          isVisible = true;
          await Future.delayed(
            const Duration(seconds: 1),
          );
          countDownNumber = i;
          update();
        }
        isVisible = false;
        email = '';
        update();
      }
    }
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}
