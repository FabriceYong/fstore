import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return FRoundedContainer(
      backgroundColor: FHelperFunctions.isDarkMode(context) ? FColors.black : FColors.white,
      padding: const EdgeInsets.all(FSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap(FSizes.spaceBtwSections),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date'),
                    Text(
                      order.formattedOrderDate,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Items'),
                    Text(
                      '${order.items.length} Items',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: FDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status'),
                    FRoundedContainer(
                      radius: FSizes.cardRadiusSm,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: FSizes.sm),
                      backgroundColor:
                          FHelperFunctions.getOrderStatusColor(order.status)
                              .withOpacity(.1),
                      child: DropdownButton<OrderStatus>(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        value: OrderStatus.pending,
                        items: OrderStatus.values.map((OrderStatus status) {
                          return DropdownMenuItem<OrderStatus>(
                            value: status,
                            child: Text(
                              status.name.capitalize.toString(),
                              style: TextStyle(
                                color: FHelperFunctions.getOrderStatusColor(
                                    order.status),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (OrderStatus? newValue) {},
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    Text(
                      '\$${order.totalAmount}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
