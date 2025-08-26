import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/controllers/customer_controller/customer_details_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/table/customer_orders_table.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/animation_loader.dart';
import 'package:f_store_dashboard/utils/loaders/normal_animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailsController.instance;
    controller.getAllCustomerOrders();
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.md),
      child: Obx(() {
        if (controller.customersLoading.value) return const FLoaderAnimation();

        if (controller.allCustomerOrders.isEmpty) {
          return const FAnimationLoaderWidget(
              text: 'No Orders Found', animation: FImages.pencilAnimation);
        }

        final totalAmount = controller.allCustomerOrders.fold<double>(0.0, (previousValue, element) => previousValue + element.totalAmount);
        return Column(
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
                      const TextSpan(text: 'Total Spent '),
                      TextSpan(
                          text: '\$${totalAmount.toString()}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .apply(color: FColors.primary)),
                      TextSpan(
                          text: ' on ${controller.allCustomerOrders.length} Orders',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(FSizes.spaceBtwItems),
            TextFormField(
              controller: controller.searchTextController,
              onChanged: (query) {
                controller.searchQuery(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search Orders',
                prefixIcon: Icon(Iconsax.search_normal),
              ),
            ),
            const Gap(FSizes.spaceBtwSections),

            // Customer Orders Table
            const CustomerOrdersTable()
          ],
        );
      }),
    );
  }
}
