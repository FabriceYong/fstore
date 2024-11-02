import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/common/widgets/products/cart/coupon_code.dart';
import 'package:fstoreapp/common/widgets/success_screen/success_screen.dart';
import 'package:fstoreapp/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:fstoreapp/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:fstoreapp/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:fstoreapp/features/shop/screens/checkout/widgets/billings_address_section.dart';
import 'package:fstoreapp/navigation_menu.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: FAppBar(
        showBackArrow: true,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              const FCartItems(
                showAddRemoveButtons: false,
              ),
              const Gap(FSizes.spaceBtwItems),

              /// -- Coupon TextField
              const FCouponCode(),
              const Gap(FSizes.spaceBtwItems),

              /// -- Billing Section
              FRoundedContainer(
                showBorder: true,
                backgroundColor: dark ? FColors.black : FColors.white,
                padding: const EdgeInsets.only(
                    top: FSizes.sm,
                    bottom: FSizes.sm,
                    right: FSizes.sm,
                    left: FSizes.md),
                child: const Column(
                  children: [
                    /// Pricing
                    FBillingAmountSection(),
                    Gap(FSizes.spaceBtwItems),
                    Divider(),
                    Gap(FSizes.spaceBtwItems),
                    FBillingPaymentSection(),
                    Gap(FSizes.spaceBtwItems),
                    FBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: FSizes.sm),
        child: ElevatedButton(
          onPressed: () => Get.to(
            () => SuccessScreen(
              image: FImages.successfulPaymentIcon,
              title: 'Payment Success',
              subTitle: 'Your item will be shipped soon',
              onPressed: () => Get.offAll(
                () => const NavigationMenu(),
              ),
            ),
          ),
          child: const Text('Checkout \$3506.56'),
        ),
      ),
    );
  }
}
