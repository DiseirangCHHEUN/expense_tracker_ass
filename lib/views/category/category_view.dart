import 'package:expense_tracker/views/category/add_category/add_category.dart';
import 'package:expense_tracker/views/category/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/custom_appbar.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'Category',
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
    );
  }
}
