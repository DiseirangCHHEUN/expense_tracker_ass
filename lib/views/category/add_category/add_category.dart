import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/constants/style_constant.dart';
import 'package:expense_tracker/utils/custom_appbar.dart';
import 'package:expense_tracker/utils/custom_textfield.dart';
import 'package:expense_tracker/views/category/add_category/controller/add_category_controller.dart';
import 'package:expense_tracker/views/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/constant_list.dart';

class AddCategoryView extends GetView<AddCategoryController> {
  AddCategoryView({super.key});
  final TextEditingController categoryNameController = TextEditingController();

  final TextEditingController categoryKhNameController =
      TextEditingController();
  final AddCategoryController _addCateController =
      Get.put(AddCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'add cate',
        leading: const BackButton(),
        actions: IconButton(
          onPressed: () {
            // save operation
          },
          icon: const Icon(Icons.save_alt_rounded),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p16, vertical: AppSizes.p20),
        children: [
          const Text(
            'Category Name',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          buildTextField(
            obscure: false,
            controller: categoryNameController,
            suffixIcon: const SizedBox(),
            keyboardType: TextInputType.text,
            hint: '',
          ),
          const SizedBox(height: AppSizes.p16),
          const Text(
            'Category Name in Khmer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          buildTextField(
            obscure: false,
            controller: categoryKhNameController,
            suffixIcon: const SizedBox(),
            keyboardType: TextInputType.text,
            hint: 'Category Name in Khmer',
          ),
          const SizedBox(height: AppSizes.p16),
          const Text(
            'Category Type',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.all(AppSizes.m10),
            width: Get.width,
            child: Wrap(
              children: [
                for (int i = 0; i <= cateType.length - 1; i++)
                  GetBuilder<AddCategoryController>(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () =>
                            _addCateController.setSelectedCateType(i: i),
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: AppSizes.m10,
                            bottom: AppSizes.m10,
                          ),
                          padding: const EdgeInsets.all(AppSizes.p10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.m5),
                            color:
                                _addCateController.currentCateTypeIndex == i &&
                                        _addCateController.isCateTypeSelected
                                    ? ColorConstants.kYellowColor
                                    : ColorConstants.kGreyColor.withOpacity(.9),
                          ),
                          child: Wrap(
                            children: [
                              Text(
                                cateType[i]['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.s12,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: AppSizes.p10),
                              Icon(
                                cateType[i]['icon'],
                                // color: Colors.black,
                                size: 17,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.p16),
          const Text(
            'Icon',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              _addCateController.pickIcon(context);
            },
            child: GetBuilder<AddCategoryController>(
              builder: (context) {
                return GetBuilder<SettingController>(
                  builder: (controller) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: AppSizes.p10),
                      margin:
                          const EdgeInsets.symmetric(vertical: AppSizes.p10),
                      width: Get.width,
                      height: AppSizes.p24 * 2,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: controller.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(AppSizes.m8),
                      ),
                      child: Row(
                        children: [
                          Text('click here to choose your icon'.tr),
                          const SizedBox(width: AppSizes.p10),
                          _addCateController.icon != null
                              ? _addCateController.icon!
                              : const Icon(Icons.category_rounded),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: AppSizes.p16),
          const Text(
            'Color',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: Get.width,
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colorList.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                    right: index == colorList.length - 1 ? 0 : AppSizes.p16),
                child: GetBuilder<AddCategoryController>(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () =>
                          _addCateController.setSelectedColor(i: index),
                      child: CircleAvatar(
                        maxRadius: 18,
                        backgroundColor: colorList[index]['color'],
                        child: _addCateController.currentColorIndex == index &&
                                _addCateController.isColorSelected
                            ? const Icon(
                                Icons.check_rounded,
                                color: ColorConstants.kWhiteColor,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.s10),
          FilledButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(ColorConstants.kRedColor),
            ),
            onPressed: () {
              // save function
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'save'.tr,
                  style: TextStyleConstant.kButtonTextStyle,
                ),
                const SizedBox(width: AppSizes.s10),
                const Icon(
                  Icons.save_rounded,
                  color: ColorConstants.kBGColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
