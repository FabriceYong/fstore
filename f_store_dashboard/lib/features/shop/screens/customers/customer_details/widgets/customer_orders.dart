import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/table/customer_orders_table.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Orders',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Total Amount '),
                    TextSpan(
                        text: '\$5000',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: FColors.primary)),
                    TextSpan(
                        text: ' on ${5} Orders',
                        style: Theme.of(context).textTheme.bodyLarge)
                  ],
                ),
              ),
            ],
          ),
          const Gap(FSizes.spaceBtwItems),
          TextFormField(
            onChanged: (query) {},
            decoration: const InputDecoration(
              hintText: 'Search Orders',
              prefixIcon: Icon(Iconsax.search_normal),
            ),
          ),
          const Gap(FSizes.spaceBtwSections),

          // Customer Orders Table
          const CustomerOrdersTable()
        ],
      ),
    );
  }
}
