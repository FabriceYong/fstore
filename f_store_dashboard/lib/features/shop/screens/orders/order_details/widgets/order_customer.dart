import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/controllers/order_controller/order_details_controller.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderDetailsController());
    controller.order.value = order;
    controller.getCustomerOfCurrentOrder();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Information
        FRoundedContainer(
          backgroundColor: FHelperFunctions.isDarkMode(context)
              ? FColors.black
              : FColors.white,
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(FSizes.spaceBtwSections),
              Obx((){
                return Row(
                  children: [
                    FRoundedImage(
                      imageType: controller.customer.value.profilePicture.isNotEmpty ? ImageType.network : ImageType.asset,
                      imageUrl: controller.customer.value.profilePicture.isNotEmpty ? controller.customer.value.profilePicture : FImages.user,
                      padding: 0,
                      backgroundColor: FHelperFunctions.isDarkMode(context)
                          ? FColors.dark
                          : FColors.primaryBackground,
                    ),
                    const Gap(FSizes.spaceBtwItems),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.customer.value.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                           Text(
                            controller.customer.value.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
              )
            ],
          ),
        ),
        const Gap(FSizes.spaceBtwSections),
        SizedBox(
          width: double.infinity,
          child: FRoundedContainer(
            backgroundColor: FHelperFunctions.isDarkMode(context)
                ? FColors.black
                : FColors.white,
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact Person',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Gap(FSizes.spaceBtwSections),
                Text(
                  controller.customer.value.fullName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(FSizes.spaceBtwItems / 2),
                Text(
                  controller.customer.value.email,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(FSizes.spaceBtwItems / 2),
                Text(
                  '+${controller.customer.value.formattedPhoneNo.isNotEmpty ? controller.customer.value.formattedPhoneNo : '(+1) *** *** ****'}',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
        ),
        const Gap(FSizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: FRoundedContainer(
            backgroundColor: FHelperFunctions.isDarkMode(context)
                ? FColors.black
                : FColors.white,
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Gap(FSizes.spaceBtwSections),
                Text(
                  order.shippingAddress != null ? order.shippingAddress!.name : '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(FSizes.spaceBtwItems / 2),
                Text(
                  order.shippingAddress != null ? order.shippingAddress!.toString() : '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ),
        const Gap(FSizes.spaceBtwSections),

        SizedBox(
          width: double.infinity,
          child: FRoundedContainer(
            backgroundColor: FHelperFunctions.isDarkMode(context)
                ? FColors.black
                : FColors.white,
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Address',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Gap(FSizes.spaceBtwSections),
                Text(
                  order.billingAddressSameAsShipping ? order.billingAddress!.name : order.shippingAddress!.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(FSizes.spaceBtwItems / 2),
                Text(
                  order.billingAddressSameAsShipping ? order.billingAddress!.toString() : order.shippingAddress!.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
