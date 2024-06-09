import 'package:expense_tracker/constants/app_size.dart';
import 'package:expense_tracker/constants/color_constant.dart';
import 'package:expense_tracker/utils/custom_appbar.dart';
import 'package:expense_tracker/utils/custom_textfield.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_iconpicker/flutter_iconpicker.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  final TextEditingController categoryNameController = TextEditingController();

  final TextEditingController categoryKhNameController =
      TextEditingController();

  late IconData _icon;

  _pickIcon() async {
    // IconData icon = await FlutterIconPicker.showIconPicker(context,
    //   iconPackMode: IconPack.cupertino);

    // _icon = icon;
    setState(() {});
    debugPrint('Picked Icon:  $_icon');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'Adds Category',
        leading: const BackButton(),
        actions: IconButton(
          onPressed: () {
            // save operation
          },
          icon: const Icon(Icons.save_alt_rounded),
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return ListView(
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
                GestureDetector(
                  onTap: () {
                    print(cateType[i]['name']);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      right: AppSizes.m10,
                      bottom: AppSizes.m10,
                    ),
                    padding: const EdgeInsets.all(AppSizes.p10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppSizes.m5),
                        color: ColorConstants.kGreyColor.withOpacity(.9)),
                    child: Wrap(
                      children: [
                        Text(
                          cateType[i]['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppSizes.s12,
                          ),
                        ),
                        const SizedBox(width: AppSizes.p10),
                        Icon(
                          cateType[i]['icon'],
                          color: Colors.black,
                          size: 17,
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        // FormBuilderChoiceChip<String>(
        //   padding: const EdgeInsets.symmetric(horizontal: AppSizes.p8),
        //   name: 'choice_chip',
        //   decoration: const InputDecoration(
        //     labelText: 'Category Type',
        //     labelStyle: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: AppSizes.s18,
        //     ),
        //   ),
        //   options: [
        //     for (int i = 0; i <= cateType.length - 1; i++)
        //       FormBuilderChipOption(
        //         value: cateType[i]['name'],
        //         child: Wrap(
        //           children: [
        //             Text(
        //               cateType[i]['name'],
        //               style: const TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: AppSizes.s12,
        //               ),
        //             ),
        //             const SizedBox(width: AppSizes.p10),
        //             Icon(
        //               cateType[i]['icon'],
        //               color: Colors.black,
        //               size: 17,
        //             )
        //           ],
        //         ),
        //       ),
        //   ],
        //   onChanged: (value) {
        //     print('Selected: $value');
        //   },
        // ),
        const SizedBox(height: AppSizes.p16),
        const Text(
          'Icon',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: AppSizes.p24 * 2),
            margin: const EdgeInsets.symmetric(vertical: AppSizes.p10),
            width: Get.width,
            height: AppSizes.p24 * 2,
            decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                width: .5,
                color: ColorConstants.kWhiteColor,
              ),
              borderRadius: BorderRadius.circular(AppSizes.m8),
            ),
            child: const Icon(Icons.category_rounded),
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
              child: CircleAvatar(
                backgroundColor: colorList[index],
              ),
            ),
          ),
        ),
      ],
    );
  }

  final colorList = [
    Colors.pink[400],
    Colors.green[600],
    Colors.cyan[400],
    Colors.cyan[900],
    Colors.cyan[600],
    Colors.cyan[800],
  ];

  final List cateType = [
    {
      'name': 'Income',
      'icon': Icons.incomplete_circle_rounded,
    },
    {
      'name': 'Expense',
      'icon': Icons.open_in_browser_rounded,
    },
    {
      'name': 'Saving',
      'icon': Icons.savings_rounded,
    },
    {
      'name': 'Dept',
      'icon': Icons.departure_board_rounded,
    },
    {
      'name': 'Loan',
      'icon': Icons.currency_bitcoin_rounded,
    },
    {
      'name': 'Investment',
      'icon': Icons.bar_chart_rounded,
    },
    {
      'name': 'Others',
      'icon': Icons.more_rounded,
    },
  ];
}
