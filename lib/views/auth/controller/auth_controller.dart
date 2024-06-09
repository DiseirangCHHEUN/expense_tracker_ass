import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  RxBool isPwdVisibility = true.obs;
  void toggleShowPwd() {
    isPwdVisibility.value = !isPwdVisibility.value;
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
}
