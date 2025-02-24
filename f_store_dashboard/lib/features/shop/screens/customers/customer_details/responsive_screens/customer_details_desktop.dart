import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/data/repositories/authentication/models/user_model.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/widgets/customer_info.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/widgets/customer_orders.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/customer_details/widgets/shipping_address.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomerDetailsDesktop extends StatelessWidget {
  const CustomerDetailsDesktop({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? Colors.black : FColors.primaryBackground,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const BreadcrumbWithHeading(
                  returnToPrevScreen: true,
                  heading: 'James Bond',
                  breadcrumbItems: [FRoutes.customerDetails, 'Details']),
              const Gap(FSizes.spaceBtwSections),

              //Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // Customer Info
                        CustomerInfo(
                          customer: customer,
                        ),
                        const Gap(FSizes.spaceBtwSections),

                        // Shipping Address
                        const ShippingAddress(),
                      ],
                    ),
                  ),
                  const Gap(FSizes.spaceBtwSections),

                  // Right Side Customer Orders
                  const Expanded(flex: 2, child: CustomerOrders())
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
