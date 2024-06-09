import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/views/category/add_category/add_category.dart';
import 'package:expense_tracker/views/category/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/custom_appbar.dart';
import '../../utils/custom_textfield.dart';

class CategoryView extends GetView<CategoryController> {
  CategoryView({super.key});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'category',
        leading: const BackButton(),
        actions: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
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
            leading: Icon(
              Icons.menu_book_outlined,
              color: Colors.purple[200],
            ),
            title: Text('expense'.tr),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 15,
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
        ],
      ),
    );
  }
}
