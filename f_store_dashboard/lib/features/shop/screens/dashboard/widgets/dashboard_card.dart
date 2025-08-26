import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/texts/section_heading.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FDashboardCard extends StatelessWidget {
  const FDashboardCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.stats,
      this.icon = Iconsax.arrow_up_3, // Default icon
      this.color = FColors.success,    // Default color
      required this.prefixIcon,
      this.onTap, this.headingColor, this.headingIcon, this.headingIconColor });

  final String title, subTitle;
  final IconData icon;
  final IconData? headingIcon;
  final Widget prefixIcon;
  final Color? color, headingColor, headingIconColor;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : Colors.white, // Revert background
      onTap: onTap,
      padding: const EdgeInsets.all(FSizes.lg),
      child: Column(
        // Removed crossAxisAlignment: CrossAxisAlignment.start
        children: [
          /// Heading
          Row(
            children: [
              prefixIcon,
              const Gap(FSizes.spaceBtwItems),
              Expanded(
                child: FSectionHeading(
                  title: title,
                  textColor: FColors.textSecondary,
                ),
              ),
            ],
          ),
          const Gap(FSizes.spaceBtwSections),

          // Re-add the Row with subtitle and comparison stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  subTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        color: color,
                        size: FSizes.iconSm,
                      ),
                      Text(
                        '$stats%', // Display stats as percentage
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                              color: color,
                              overflow: TextOverflow.ellipsis,
                            ),
                      )
                    ],
                  ),
                  Text(
                    'Compared to Dec 2025', // Restore hardcoded text
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
