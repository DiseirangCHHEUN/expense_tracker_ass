import 'package:expense_tracker/views/category/add_category/data/constant_list.dart';
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
}
