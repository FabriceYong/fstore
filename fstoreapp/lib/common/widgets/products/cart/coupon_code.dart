import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';

class FCouponCode extends StatelessWidget {
  const FCouponCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return FRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? FColors.black : FColors.white,
      padding: const EdgeInsets.only(
          top: FSizes.sm, bottom: FSizes.sm, right: FSizes.sm, left: FSizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Have a promo code ? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),

          /// Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: dark
                      ? FColors.white.withOpacity(.5)
                      : FColors.dark.withOpacity(.5),
                  backgroundColor: Colors.grey.withOpacity(.2),
                  side: BorderSide(color: Colors.grey.withOpacity(.1))),
              onPressed: () {},
              child: const Text('Apply'),
            ),
          ),
        ],
      ),
    );
  }
}
