import 'package:f_store_dashboard/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FMenuItem extends StatelessWidget {
  const FMenuItem({
    super.key,
    required this.route,
    required this.icon,
    required this.itemName,
  });
  final String route;
  final IconData icon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SidebarController());
    final dark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () => controller.menuOnTap(route),
      onHover: (hovering) => hovering
          ? controller.changeHoverItem(route)
          : controller.changeHoverItem(''),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: FSizes.xs),
          child: Container(
            decoration: BoxDecoration(
              color: controller.isHovering(route) || controller.isActive(route)
                  ? FColors.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(FSizes.cardRadiusMd),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Padding(
                  padding: const EdgeInsets.only(
                      left: FSizes.lg,
                      top: FSizes.md * .6,
                      bottom: FSizes.md * .6,
                      right: FSizes.md * .6),
                  child: controller.isActive(route)
                      ? Icon(
                          icon,
                          color: FColors.white,
                          size: 22,
                        )
                      : Icon(
                          icon,
                          size: 22,
                          color: controller.isHovering(route)
                              ? FColors.white
                              : FColors.darkGrey,
                        ),
                ),

                // Text
                if (controller.isHovering(route) || controller.isActive(route))
                  Flexible(
                    child: Text(
                      itemName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: FColors.white),
                    ),
                  )
                else
                  Flexible(
                      child: Text(
                    itemName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: FColors.darkGrey),
                  ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
