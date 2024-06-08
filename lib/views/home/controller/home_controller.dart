import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var textController = TextEditingController();
  List pageItem = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  int currentIndex = 0;

  void goPreviouse() {
    currentIndex == 0 ? currentIndex = 0 : currentIndex--;
    update();
  }

  void goNext() {
    int limitNum = pageItem.length - 1;
    currentIndex == limitNum ? currentIndex = limitNum : currentIndex++;
    update();
  }

  addNewItemToList({required String newItem}) {
    pageItem.add(newItem);
    update();
  }
}
