import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class FTableHeader extends StatelessWidget {
  const FTableHeader(
      {super.key,
      this.onPressed,
      this.buttonText = 'Add',
      this.controller,
      this.searchOnChanged,
      this.showLeftWidget = true,
      this.filterOptions,
      this.onFilterSelected,
      this.selectedFilter,
      this.showExportButton = false,
      this.onExportPressed,
      this.hintText = 'Search here...'});

  final Function()? onPressed;
  final String buttonText;
  final bool showLeftWidget;
  final TextEditingController? controller;
  final Function(String)? searchOnChanged;
  final List<String>? filterOptions;
  final Function(String?)? onFilterSelected;
  final String? selectedFilter;
  final bool showExportButton;
  final Function()? onExportPressed;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = FHelperFunctions.isDarkMode(context);

    return FDeviceUtils.isMobileScreen(context)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action buttons row
              Row(
                children: [
                  if (showLeftWidget)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onPressed,
                        icon: const Icon(Iconsax.add),
                        label: Text(buttonText),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: FColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  if (showExportButton) ...[
                    const Gap(FSizes.sm),
                    IconButton(
                      onPressed: onExportPressed,
                      icon: const Icon(Iconsax.export_1),
                      tooltip: 'Export data',
                      style: IconButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? FColors.darkerGrey
                            : FColors.grey.withOpacity(0.2),
                      ),
                    ),
                  ],
                ],
              ),
              const Gap(FSizes.spaceBtwItems),

              // Search field
              TextFormField(
                controller: controller,
                onChanged: searchOnChanged,
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: const Icon(Iconsax.search_normal),
                  filled: true,
                  fillColor: isDarkMode
                      ? FColors.darkerGrey.withOpacity(0.5)
                      : FColors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(FSizes.borderRadiusSm),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),

              // Filter dropdown if available
              if (filterOptions != null && filterOptions!.isNotEmpty) ...[
                const Gap(FSizes.spaceBtwItems),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? FColors.darkerGrey.withOpacity(0.5)
                        : FColors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(FSizes.borderRadiusSm),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedFilter,
                      hint: const Text('Filter by'),
                      icon: const Icon(Iconsax.filter),
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child: Text('All'),
                        ),
                        ...filterOptions!
                            .map((option) => DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(option),
                                )),
                      ],
                      onChanged: onFilterSelected,
                    ),
                  ),
                ),
              ],
            ],
          )
        : Row(
            children: [
              // Left side - Add button
              Expanded(
                flex: 2,
                child: showLeftWidget
                    ? Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: ElevatedButton.icon(
                              onPressed: onPressed,
                              icon: const Icon(Iconsax.add),
                              label: Text(buttonText),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: FColors.primary,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          if (showExportButton) ...[
                            const Gap(FSizes.sm),
                            IconButton(
                              onPressed: onExportPressed,
                              icon: const Icon(Iconsax.export_1),
                              tooltip: 'Export data',
                              style: IconButton.styleFrom(
                                backgroundColor: isDarkMode
                                    ? FColors.darkerGrey
                                    : FColors.grey.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ],
                      )
                    : const SizedBox.shrink(),
              ),

              // Right side - Search and filter
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    // Filter dropdown if available
                    if (filterOptions != null && filterOptions!.isNotEmpty) ...[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(right: FSizes.sm),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? FColors.darkerGrey.withOpacity(0.5)
                                : FColors.grey.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(FSizes.borderRadiusSm),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: selectedFilter,
                              hint: const Text('Filter by'),
                              icon: const Icon(Iconsax.filter),
                              items: [
                                const DropdownMenuItem<String>(
                                  value: null,
                                  child: Text('All'),
                                ),
                                ...filterOptions!
                                    .map((option) => DropdownMenuItem<String>(
                                          value: option,
                                          child: Text(option),
                                        )),
                              ],
                              onChanged: onFilterSelected,
                            ),
                          ),
                        ),
                      ),
                    ],

                    // Search field
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: controller,
                        onChanged: searchOnChanged,
                        decoration: InputDecoration(
                          hintText: hintText,
                          prefixIcon: const Icon(Iconsax.search_normal),
                          filled: true,
                          fillColor: isDarkMode
                              ? FColors.darkerGrey.withOpacity(0.5)
                              : FColors.grey.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(FSizes.borderRadiusSm),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
