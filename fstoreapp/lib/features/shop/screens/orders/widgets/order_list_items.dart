import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:fstoreapp/features/shop/controllers/product/order_controller.dart';
import 'package:fstoreapp/features/shop/screens/home/home.dart';
import 'package:fstoreapp/navigation_menu.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/image_strings.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/cloud_helper_functions.dart';
import 'package:fstoreapp/utils/helpers/helper_functions.dart';
import 'package:fstoreapp/utils/loaders/animation_loader.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FOrderListItems extends StatelessWidget {
  const FOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = FHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        /// Nothing Found Widget
        final emptyWidget = FAnimationLoaderWidget(
          text: 'Whoops! No Orders Yet!',
          animation: FImages.orderCompleteAnimation,
          showAction: true,
          actionText: 'Let\'s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        /// Helper function: Handle Loader, No Record, Or Error Message
        final response = FCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        /// Congratulations! Record found
        final orders = snapshot.data!;

        return ListView.separated(
            shrinkWrap: true,
            itemCount: orders.length,
            separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final order = orders[index];
              return FRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(FSizes.md),
                backgroundColor: dark ? FColors.darkerGrey : FColors.grey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        /// Icon
                        const Icon(Iconsax.ship),
                        const Gap(FSizes.spaceBtwItems / 2),

                        /// Status & DAte
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.orderStatus,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .apply(
                                        color: FColors.primary,
                                        fontWeightDelta: 1),
                              ),
                              Text(
                                order.formattedOrderDate,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),

                        /// Icon
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.arrow_right_34,
                            size: FSizes.iconSm,
                          ),
                        )
                      ],
                    ),
                    const Gap(FSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              /// Icon
                              const Icon(Iconsax.tag),
                              const Gap(FSizes.spaceBtwItems / 2),

                              /// Status & DAte
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      order.id,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              /// Icon
                              const Icon(Iconsax.calendar),
                              const Gap(FSizes.spaceBtwItems / 2),

                              /// Status & DAte
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Shipping Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      order.formattedDeliveryDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}
