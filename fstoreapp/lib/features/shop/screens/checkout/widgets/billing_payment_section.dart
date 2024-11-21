import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/controllers/product/checkout_controller.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FBillingPaymentSection extends StatelessWidget {
  const FBillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final controller = Get.put(CheckoutController());
    return Column(
      children: [
        FSectionHeading(
          title: 'Payment Method',
          buttonTitle: 'Change',
          onPressed: () => controller.selectPaymentMethod(context),
        ),
        const Gap(FSizes.spaceBtwItems / 2),
        Obx(
          () => Row(
            children: [
              FRoundedContainer(
                width: 60,
                height: 35,
                backgroundColor: dark ? FColors.light : FColors.white,
                padding: const EdgeInsets.all(FSizes.sm),
                child: Image.asset(
                  controller.selectedPaymentMethod.value.image,
                  fit: BoxFit.contain,
                ),
              ),
              const Gap(FSizes.spaceBtwItems),
              Text(controller.selectedPaymentMethod.value.name,
                  style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
        )
      ],
    );
  }
}
