import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/models/category_model/category_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Label
          Text(
            'Categories',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(FSizes.spaceBtwItems),

          // MultiSelectDialogField for Selecting Categories
          MultiSelectDialogField(
            buttonText: const Text('Select Categories'),
            title: const Text('Categories'),
            items: [
              MultiSelectItem(
                  CategoryModel(id: 'id', name: 'Shoes', image: 'image'),
                  'Shoes'),
              MultiSelectItem(
                  CategoryModel(id: 'id', name: 'Shirts', image: 'image'),
                  'Shirts'),
              MultiSelectItem(
                  CategoryModel(id: 'id', name: 'Pants', image: 'image'),
                  'Pants'),
              MultiSelectItem(
                  CategoryModel(id: 'id', name: 'Watches', image: 'image'),
                  'Watches')
            ],
            listType: MultiSelectListType.CHIP,
            onConfirm: (values) {},
          )
        ],
      ),
    );
  }
}
