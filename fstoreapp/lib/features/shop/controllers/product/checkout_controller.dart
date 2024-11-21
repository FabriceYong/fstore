import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/text/section_heading.dart';
import 'package:fstoreapp/features/shop/models/payment_method_model.dart';
import 'package:fstoreapp/features/shop/screens/checkout/widgets/payment_tile.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Paypal', image: FImages.paypal);
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(FSizes.lg),
          child: Column(
            children: [
              const FSectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              const Gap(FSizes.spaceBtwSections),
              FPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paypal', image: FImages.paypal)),
              const Gap(FSizes.spaceBtwItems / 2),
              FPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Google Pay', image: FImages.googlePay)),
              const Gap(FSizes.spaceBtwItems / 2),
              FPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Apple Pay', image: FImages.applePay)),
              const Gap(FSizes.spaceBtwItems / 2),
              FPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'VISA', image: FImages.visa)),
              const Gap(FSizes.spaceBtwItems / 2),
              FPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Master Card', image: FImages.masterCard)),
              const Gap(FSizes.spaceBtwItems / 2),
              FPaymentTile(
                  paymentMethod:
                      PaymentMethodModel(name: 'Paytm', image: FImages.paytm)),
              const Gap(FSizes.spaceBtwItems / 2),
              FPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Paystack', image: FImages.paystack)),
              const Gap(FSizes.spaceBtwItems / 2),
              FPaymentTile(
                  paymentMethod: PaymentMethodModel(
                      name: 'Credit Card', image: FImages.creditCard)),
              const Gap(FSizes.spaceBtwItems / 2),
            ],
          ),
        ),
      ),
    );
  }
}
