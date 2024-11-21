import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/features/shop/controllers/product/checkout_controller.dart';
import 'package:fstoreapp/features/shop/models/payment_method_model.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/enums.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FPaymentTile extends StatelessWidget {
  const FPaymentTile({super.key, required this.paymentMethod});

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final controller = CheckoutController.instance;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        controller.selectedPaymentMethod.value = paymentMethod;
        Get.back();
      },
      leading: FRoundedContainer(
        width: 60,
        height: 40,
        backgroundColor: FHelperFunctions.isDarkMode(context)
            ? FColors.light
            : FColors.white,
        padding: const EdgeInsets.all(FSizes.sm),
        child: Image.asset(
          paymentMethod.image,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        paymentMethod.name,
      ),
      trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
