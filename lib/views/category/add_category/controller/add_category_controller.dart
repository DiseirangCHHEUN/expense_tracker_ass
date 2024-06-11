import 'package:expense_tracker/views/category/add_category/data/constant_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';

class AddCategoryController extends GetxController {
  // select category type
  bool isCateTypeSelected = false;
  int currentCateTypeIndex = cateType.length + 1;
  void setSelectedCateType({required int i}) {
    currentCateTypeIndex = i;
    isCateTypeSelected = true;
    update();
  }

  // select color for category

  bool isColorSelected = false;
  int currentColorIndex = colorList.length + 1;
  void setSelectedColor({required int i}) {
    currentColorIndex = i;
    isColorSelected = true;
    update();
  }

  Icon? icon;

  pickIcon(BuildContext context) async {
    IconData? iconData = await showIconPicker(
      context,
      iconSize: 30,
      title: Text('pick an icon'.tr),
      closeChild: Text('close'.tr),
      searchHintText: 'search'.tr,
      iconPackModes: [IconPack.cupertino],
    );

    icon = Icon(iconData);
    update();
    debugPrint('Picked Icon:  $iconData');
  }
}
