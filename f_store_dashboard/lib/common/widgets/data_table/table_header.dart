import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FTableHeader extends StatelessWidget {
  const FTableHeader(
      {super.key,
      this.onPressed,
      required this.buttonText,
      this.controller,
      this.searchOnChanged});

  final Function()? onPressed;
  final String buttonText;

  final TextEditingController? controller;
  final Function(String)? searchOnChanged;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: FDeviceUtils.isDesktopScreen(context) ? 3 : 1,
        child: Row(
          children: [
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText),
              ),
            ),
          ],
        ),
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
