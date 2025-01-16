import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductVisibilityWidget extends StatelessWidget {
  const ProductVisibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility Header
          Text(
            'Visibility',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Gap(FSizes.spaceBtwItems),

          // Radio Buttons for Product Visibility
          Column(
            children: [
              _buildVisibilityRadioButton(
                  ProductVisibility.published, 'Published'),
              _buildVisibilityRadioButton(ProductVisibility.hidden, 'Hidden'),
            ],
          )
        ],
      ),
    );
  }

  // Helper Method to Build a Radio Button for Product Visibility
  Widget _buildVisibilityRadioButton(
      ProductVisibility visibility, String label) {
    return RadioMenuButton<ProductVisibility>(
      value: visibility,
      groupValue: ProductVisibility.published,
      onChanged: (value) {},
      child: Text(label),
    );
  }
}
