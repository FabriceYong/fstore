import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FTableHeader extends StatelessWidget {
  const FTableHeader(
      {super.key,
      this.onPressed,
      this.buttonText = 'Add',
      this.controller,
      this.searchOnChanged,
      this.showLeftWidget = true});

  final Function()? onPressed;
  final String buttonText;
  final bool showLeftWidget;
  final TextEditingController? controller;
  final Function(String)? searchOnChanged;

  @override
  Widget build(BuildContext context) {
    return FDeviceUtils.isMobileScreen(context)
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            showLeftWidget
                ? SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child: Text(buttonText),
                    ),
                  )
                : const SizedBox.shrink(),
            const Gap(FSizes.spaceBtwItems),
            TextFormField(
              controller: controller,
              onChanged: searchOnChanged,
              decoration: const InputDecoration(
                hintText: 'Search here...',
                prefixIcon: Icon(Iconsax.search_normal),
              ),
            ),
          ])
        : Row(children: [
            Expanded(
              flex: FDeviceUtils.isDesktopScreen(context) ? 3 : 1,
              child: showLeftWidget
                  ? Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: onPressed,
                            child: Text(buttonText),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              flex: FDeviceUtils.isDesktopScreen(context) ? 1 : 2,
              child: TextFormField(
                controller: controller,
                onChanged: searchOnChanged,
                decoration: const InputDecoration(
                  hintText: 'Search here...',
                  prefixIcon: Icon(Iconsax.search_normal),
                ),
              ),
            ),
          ]);
  }
}
