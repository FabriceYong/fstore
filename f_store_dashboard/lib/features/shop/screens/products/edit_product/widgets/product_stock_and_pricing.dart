import 'package:f_store_dashboard/features/shop/controllers/product/edit_product_controller.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductStockAndPricing extends StatelessWidget {
  const ProductStockAndPricing({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = EditProductController.instance;
    return Obx(
      () => controller.productType.value == ProductType.single
          ? Form(
              key: controller.stockPriceFormKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stock
                    FractionallySizedBox(
                      widthFactor: .45,
                      child: TextFormField(
                        controller: controller.stock,
                        decoration: const InputDecoration(
                          labelText: 'Stock',
                          hintText: 'Add Stock: Only Numbers Are Allowed',
                        ),
                        validator: (value) =>
                            FValidator.validateEmptyText('Stock', value),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    const Gap(FSizes.spaceBtwInputFields),

                    // Pricing
                    Row(children: [
                      // Price
                      Expanded(
                        child: TextFormField(
                          controller: controller.price,
                          decoration: const InputDecoration(
                              labelText: 'Price',
                              hintText: 'Price With Up-To 2 Decimals'),
                          validator: (value) =>
                              FValidator.validateEmptyText('Price', value),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}$'),
                            ),
                          ],
                        ),
                      ),
                      const Gap(FSizes.spaceBtwItems),

                      // Sale Price
                      Expanded(
                        child: TextFormField(
                          controller: controller.salePrice,
                          decoration: const InputDecoration(
                              labelText: 'Discounted Price',
                              hintText:
                                  'Discounted Price With Up-To 2 Decimals'),
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,2}$'),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ]),
            )
          : const SizedBox.shrink(),
    );
  }
}
