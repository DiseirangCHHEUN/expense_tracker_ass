import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/views/category/add_category/add_category_view.dart';
import 'package:expense_tracker/views/category/add_category/controller/add_category_controller.dart';
import 'package:expense_tracker/views/category/controller/category_controller.dart';
import 'package:expense_tracker/views/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/custom_appbar.dart';
import '../../utils/custom_textfield.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({super.key});
  final TextEditingController searchController = TextEditingController();
  final AddCategoryController addCategoryController =
      Get.put(AddCategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'category',
        leading: const BackButton(),
        actions: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            // showCupertinoModalBottomSheet(
            //   context: context,
            //   builder: (context) => AddCategoryView(),
            // );
            Get.to(
              () => AddCategoryView(),
              transition: Transition.rightToLeft,
              duration: const Duration(milliseconds: 300),
            );
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.p8,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.p22,
              vertical: AppSizes.p10,
            ),
            child: buildTextField(
                obscure: false,
                controller: searchController,
                suffixIcon: const SizedBox(),
                keyboardType: TextInputType.text,
                hint: 'search'),
          ),
          ExpansionTile(
            initiallyExpanded: true,
            leading: Icon(
              Icons.menu_book_outlined,
              color: Colors.purple[200],
            ),
            title: Text('income'.tr),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.abc),
                  title: Text('income'.tr),
                  trailing: const Text(
                    'Default',
                    style: TextStyle(fontSize: AppSizes.s14),
                  ),
                ),
              )
            ],
          ),
          ExpansionTile(
            initiallyExpanded: true,
            leading: Icon(
              Icons.menu_book_outlined,
              color: Colors.purple[200],
            ),
            title: Text('expense'.tr),
            children: [
              GetBuilder<AddCategoryController>(builder: (context) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: addCategoryController.categoryList.length,
                  itemBuilder: (context, index) {
                    var category = addCategoryController.categoryList[index];
                    int icon =
                        int.parse(category.iconCode!.substring(2), radix: 16);
                    print(icon);
                    String color = category.color!;
                    return ListTile(
                      leading: Icon(
                        IconData(icon, fontFamily: 'cupertino'),
                        color: Color(int.parse(color)),
                      ),
                      title:
                          GetBuilder<SettingController>(builder: (controller) {
                        return Text(
                          '${controller.isEnglish ? category.enName : category.khName}',
                        );
                      }),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.p10,
                          vertical: AppSizes.p5,
                        ),
                        decoration: BoxDecoration(
                          color: category.isDefault == 1
                              ? ColorConstants.kGreenColor.withOpacity(.5)
                              : ColorConstants.kGreyColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          category.isDefault == 1 ? 'Custom' : 'Default',
                          style: const TextStyle(
                            fontSize: AppSizes.s12,
                          ),
                        ),
                      ),
                    );
                  },
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
