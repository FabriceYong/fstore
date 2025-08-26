import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/edit_product_controller.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_model.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductBottomNavigationButtons extends StatelessWidget {
  const ProductBottomNavigationButtons({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      // backgroundColor:
      //     FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.sm),
      radius: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text('Discard'),
          ),
          const Gap(FSizes.spaceBtwItems / 2),
          SizedBox(
            width: 160,
            child: ElevatedButton(
                onPressed: () =>
                    EditProductController.instance.editProduct(product),
                child: const Text('Save Changes')),
          )
        ],
      ),
    );
  }
}
