import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/models/brand_model/brand_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class ProductBrand extends StatelessWidget {
  const ProductBrand({super.key});

  @override
  Widget build(BuildContext context) {
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
          TypeAheadField(
              builder: (context, ctr, focusNode) {
                return TextFormField(
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select Brand',
                    suffixIcon: Icon(Iconsax.box),
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                // Return Filtered Brand Suggestions Based On The Search Pattern
                return [
                  BrandModel(id: 'id', name: 'Nike', image: FImages.nikeLogo),
                  BrandModel(
                      id: 'id', name: 'Adidas', image: FImages.adidasLogo),
                  BrandModel(id: 'id', name: 'Apple', image: FImages.appleLogo),
                  BrandModel(id: 'id', name: 'IKEA', image: FImages.ikeaLogo),
                ];
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.name),
                );
              },
              onSelected: (suggestion) {})
        ],
      ),
    );
  }
}
