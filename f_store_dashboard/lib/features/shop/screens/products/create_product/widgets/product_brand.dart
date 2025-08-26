import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/schimmers/shimmer_effect.dart';
import 'package:f_store_dashboard/features/shop/controllers/brands_controller/brands_controller.dart';
import 'package:f_store_dashboard/features/shop/controllers/product/create_product_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
    // Create instance of controllers
    final controller = Get.put(CreateProductController());
    final brandController = Get.put(BrandsController());

    // Fetch brands if the list is empty
    if (brandController.allItems.isEmpty) brandController.fetchItems();

    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Brand',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(FSizes.spaceBtwItems),

          // TypeAheadField For Brand Selection
          Obx(
            () => brandController.isLoading.value
                ? const FShimmerEffect(width: double.infinity, height: 50)
                : TypeAheadField(builder: (context, ctr, focusNode) {
                    return TextFormField(
                      controller: controller.brandTextField = ctr,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Select Brand',
                        suffixIcon: Icon(Iconsax.box),
                      ),
                    );
                  }, suggestionsCallback: (pattern) {
                    // Return Filtered Brand Suggestions Based On The Search Pattern
                    return brandController.allItems
                        .where((brand) => brand.name.contains(pattern))
                        .toList();
                  }, itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion.name),
                    );
                  }, onSelected: (suggestion) {
                    // controller.brandTextField.clear();
                    controller.selectedBrand.value = suggestion;
                    controller.brandTextField.text = suggestion.name;
                  }),
          )
        ],
      ),
    );
  }
}
