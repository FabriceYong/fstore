import 'package:f_store_dashboard/features/shop/controllers/product/create_product_controller.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CreateProductController.instance;
    return Obx(
      () => Row(
        children: [
          Text(
            'Product Type',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Gap(FSizes.spaceBtwItems),
          // Radio Button Form Single Product Type
          RadioMenuButton(
              value: ProductType.single,
              groupValue: controller.productType.value,
              onChanged: (value) {
                // Update the selected productType in the controller
                controller.productType.value = value ?? ProductType.single;
              },
              child: const Text('Single')),

          // Radio Button For Variable   Product Type
          RadioMenuButton(
            value: ProductType.variable,
            groupValue: controller.productType.value,
            onChanged: (value) {
              // Update the selected productType in the controller
              controller.productType.value = value ?? ProductType.variable;
            },
            child: const Text('Variable'),
          )
        ],
      ),
    );
  }
}
