import 'package:expense_tracker/views/category/add_category/data/constant_list.dart';
import 'package:get/get.dart';

class AddCategoryController extends GetxController {
  //  late IconData _icon;

  // _pickIcon() async {
  //   IconData icon = await FlutterIconPicker.showIconPicker(context,
  //     iconPackMode: IconPack.material);

  //   _icon = icon;
  //   setState((){});
  //   debugPrint('Picked Icon:  $_icon');
  // }


  // select category type
  bool isCateTypeSelected = false;
  int currentCateTypeIndex = cateType.length+1;
  void setSelectedCateType({required int i}) {
    currentCateTypeIndex = i;
    isCateTypeSelected = true;
    update();
  }

  // select color for category

   bool isColorSelected = false;
  int currentColorIndex = colorList.length+1;
  void setSelectedColor({required int i}) {
    currentColorIndex = i;
    isColorSelected = true;
    update();
  }

}
