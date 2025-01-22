import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(0.0,
        (prevValue, element) => prevValue + (element.price * element.quantity));
    return FRoundedContainer(
      backgroundColor:
          FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Items',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(FSizes.spaceBtwSections),

          // Items
          ListView.separated(
            shrinkWrap: true,
            itemCount: order.items.length,
            separatorBuilder: (_, __) => const Gap(FSizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final item = order.items[index];
              return Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        FRoundedImage(
                          backgroundColor: FHelperFunctions.isDarkMode(context)
                              ? FColors.dark
                              : FColors.primaryBackground,
                          imageType: item.image != null
                              ? ImageType.network
                              : ImageType.asset,
                          imageUrl: item.image ?? FImages.defaultImageIcon,
                        ),
                        const Gap(FSizes.spaceBtwItems),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (item.selectedVariations != null)
                                Text(item.selectedVariations!.entries
                                    .map((e) => ('${e.key} : ${e.value} '))
                                    .toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(FSizes.spaceBtwItems),
                  SizedBox(
                    width: FSizes.xl * 2,
                    child: Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width: FDeviceUtils.isMobileScreen(context)
                        ? FSizes.xl * 1.4
                        : FSizes.xl * 2,
                    child: Text(
                      item.quantity.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(
                    width: FDeviceUtils.isMobileScreen(context)
                        ? FSizes.xl * 1.4
                        : FSizes.xl * 2,
                    child: Text(
                      '\$${item.totalAmount}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                ],
              );
            },
          ),
          const Gap(FSizes.spaceBtwSections),

          // Items Total
          FRoundedContainer(
            backgroundColor: FHelperFunctions.isDarkMode(context)
                ? FColors.dark
                : FColors.primaryBackground,
            padding: const EdgeInsets.all(FSizes.defaultSpace),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub-Total',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$$subTotal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Gap(FSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${0.00}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Gap(FSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Shipping',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '\$${FPricingCalculator.calculateShippingCost(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                  ],
                ),
                const Gap(FSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tax', style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      '\$${FPricingCalculator.calculateTax(subTotal, '')}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Gap(FSizes.spaceBtwItems),
                const Divider(),
                const Gap(FSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      '\$${FPricingCalculator.calculateTotalPrice(subTotal, '')}',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
