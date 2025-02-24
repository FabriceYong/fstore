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
      this.icon = Iconsax.arrow_up_3,
      this.color = FColors.success,
      required this.prefixIcon,
      this.onTap});

  final String title, subTitle;
  final IconData icon;
  final Widget prefixIcon;
  final Color color;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : Colors.white,
      onTap: onTap,
      padding: const EdgeInsets.all(FSizes.lg),
      child: Column(
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subTitle,
                style: Theme.of(context).textTheme.headlineMedium,
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
                        '$stats%',
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                              color: color,
                              overflow: TextOverflow.ellipsis,
                            ),
                      )
                    ],
                  ),
                  Text(
                    'Compared to Dec 2025',
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
