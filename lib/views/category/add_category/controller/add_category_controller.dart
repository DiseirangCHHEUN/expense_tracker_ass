import 'package:expense_tracker/views/category/add_category/data/constant_list.dart';
import 'package:expense_tracker/helper/database_helper.dart';
import 'package:expense_tracker/views/category/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';

class AddCategoryController extends GetxController {
  final TextEditingController enNameController = TextEditingController();
  final TextEditingController khNameController = TextEditingController();
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
    if (iconData != null) {
      icon = Icon(iconData);
    } else {
      icon = const Icon(Icons.category);
    }
    update();
    print(icon.toString().substring(14, 21));

    debugPrint('Picked Icon:  $icon');
  }

  resetValue() {
    isCateTypeSelected = false;
    currentCateTypeIndex = cateType.length + 1;
    icon = const Icon(Icons.category);
    isColorSelected = false;
    currentColorIndex = colorList.length + 1;
    update();
  }

  // working with category
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late Future<List<Category>> categories;

  @override
  void onInit() {
    // _databaseHelper.deleteDatabaseFile();
    categories = _databaseHelper.getCategories();
    getAllCategories();
    super.onInit();
  }

  List<Category> categoryList = [];
  void getAllCategories() async {
    categoryList = await categories;
    update();
  }

  void refreshCategory() {
    categories = _databaseHelper.getCategories();
    getAllCategories();
    update();
  }

  Future<void> insertCategory() async {
    var iconCode = icon.toString().substring(14, 21);

    await _databaseHelper.insertCategory(
      Category(
        enName: enNameController.text,
        khName: khNameController.text,
        cateType: cateType[currentCateTypeIndex]['name'],
        iconCode: iconCode,
        color: colorList[currentColorIndex]['value'],
        isDefault: 1,
      ),
    );
    getAllCategories();
    refreshCategory();
    resetValue();
    Get.back();
  }

  Future<void> updateCategory({
    required int id,
    required String enName,
    required String khName,
    required String cateType,
    required String iconCode,
    required String color,
  }) async {
    await _databaseHelper.updateCategory(
      Category(
        id: id,
        enName: enName,
        khName: khName,
        cateType: cateType,
        iconCode: iconCode,
        color: color,
        isDefault: 0,
      ),
    );
  }

  Future<void> deleteCategory({required int id}) async {
    await _databaseHelper.deleteCategory(id);
    refreshCategory();
  }
}
