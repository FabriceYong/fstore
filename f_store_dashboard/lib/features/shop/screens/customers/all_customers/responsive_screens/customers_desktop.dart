import 'package:f_store_dashboard/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/data_table/table_header.dart';
import 'package:f_store_dashboard/features/shop/screens/customers/all_customers/table/data_table.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomersDesktopScreen extends StatelessWidget {
  const CustomersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? Colors.black : FColors.primaryBackground,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BreadCrumbs
              BreadcrumbWithHeading(
                  heading: 'Customers', breadcrumbItems: ['Customers']),
              Gap(FSizes.spaceBtwSections),

              FRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    FTableHeader(
                      showLeftWidget: false,
                    ),
                    Gap(FSizes.spaceBtwItems),

                    // Table
                    CustomersTable()
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
