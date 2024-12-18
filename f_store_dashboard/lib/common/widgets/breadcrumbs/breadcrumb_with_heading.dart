import 'package:f_store_dashboard/common/widgets/layouts/headers/page_heading.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BreadcrumbWithHeading extends StatelessWidget {
  const BreadcrumbWithHeading(
      {super.key,
      required this.heading,
      required this.breadcrumbItems,
      this.returnToPrevScreen = false});
  // The heading for the page
  final String heading;

  // List of breadcrumb items representing the navigation path
  final List<String> breadcrumbItems;

  // Flag indicating whether to include a button to return to the previous path
  final bool returnToPrevScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Breadcrumb trail
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Get.offAllNamed(FRoutes.dashboard),
              child: Padding(
                padding: const EdgeInsets.all(FSizes.xs),
                child: Text(
                  'Dashboard',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(fontWeightDelta: -1),
                ),
              ),
            ),
            for (int i = 0; i < breadcrumbItems.length; i++)
              Row(
                children: [
                  const Text('/'), // Separator
                  InkWell(
                    // Last item should not be clickable
                    onTap: i == breadcrumbItems.length - 1
                        ? null
                        : () => Get.toNamed(breadcrumbItems[i]),
                    child: Padding(
                      padding: const EdgeInsets.all(FSizes.xs),
                      // Format breadcrumb item: capitalize and remove leading '/
                      child: Text(
                        i == breadcrumbItems.length - 1
                            ? breadcrumbItems[i].capitalize.toString()
                            : capitalize(breadcrumbItems[i].substring(1)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontWeightDelta: -1),
                      ),
                    ),
                  )
                ],
              )
          ],
        ),
        const Gap(FSizes.sm),

        // Heading of the page
        Row(
          children: [
            if (returnToPrevScreen)
              IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Iconsax.arrow_left)),
            if (returnToPrevScreen) const Gap(FSizes.spaceBtwItems),
            FPageHeading(heading: heading)
          ],
        )
      ],
    );
  }
}

// Function to capitalize the first letter of a string
String capitalize(String route) {
  return route.isEmpty ? '' : route[0].toLowerCase() + route.substring(1);
}
