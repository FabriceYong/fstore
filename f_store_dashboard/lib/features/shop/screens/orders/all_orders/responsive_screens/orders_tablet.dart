import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/data_table/table_header.dart';
import 'package:f_store_dashboard/features/shop/controllers/order_controller/order_controller.dart';
import 'package:f_store_dashboard/features/shop/screens/orders/all_orders/table/table_data.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/loaders/normal_animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrdersTabletScreen extends StatelessWidget {
  const OrdersTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return Scaffold(
      backgroundColor: FHelperFunctions.isDarkMode(context)
          ? Colors.black
          : FColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const BreadcrumbWithHeading(
                  heading: 'Orders', breadcrumbItems: ['Orders']),
              const Gap(FSizes.spaceBtwSections),

              // Body
              FRoundedContainer(
                child: Column(
                  children: [
                     FTableHeader(
                      showLeftWidget: false,
                      hintText: 'Search items by id...',
                      controller: controller.searchController,
                      searchOnChanged: (query) => controller.searchItems(query),
                    ),
                    const Gap(FSizes.spaceBtwItems),

                    //Table
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const FLoaderAnimation();
                      }
                      return const OrdersTable();
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
