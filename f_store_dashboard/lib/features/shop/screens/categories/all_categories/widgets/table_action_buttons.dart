import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FTableActionButtons extends StatelessWidget {
  const FTableActionButtons({
    super.key,
    this.view = false,
    this.edit = true,
    this.delete = true,
    this.onViewPressed,
    this.onEditPressed,
    this.onDeletePressed,
  });

  /// Flag to determine whether the view button is enabled
  final bool view;

  /// Flag to determine whether the edit button is enabled
  final bool edit;

  /// Flag to determine whether the delete button is enabled;
  final bool delete;

  /// Function to be called when the view button is pressed
  final VoidCallback? onViewPressed;

  /// Function to be called when the edit button is pressed
  final VoidCallback? onEditPressed;

  /// Function to be called when the delete button is pressed
  final VoidCallback? onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (view)
          Tooltip(
            message: 'View details',
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: FColors.darkerGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(FSizes.borderRadiusSm),
              ),
              child: IconButton(
                constraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),
                padding: const EdgeInsets.all(4),
                onPressed: onViewPressed,
                icon: const Icon(
                  Iconsax.eye,
                  size: 18,
                  color: FColors.darkerGrey,
                ),
              ),
            ),
          ),
        if (edit)
          Tooltip(
            message: 'Edit',
            child: Container(
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: FColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(FSizes.borderRadiusSm),
              ),
              child: IconButton(
                constraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),
                padding: const EdgeInsets.all(4),
                onPressed: onEditPressed,
                icon: const Icon(
                  Iconsax.edit,
                  size: 18,
                  color: FColors.primary,
                ),
              ),
            ),
          ),
        if (delete)
          Tooltip(
            message: 'Delete',
            child: Container(
              decoration: BoxDecoration(
                color: FColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(FSizes.borderRadiusSm),
              ),
              child: IconButton(
                constraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 30,
                ),
                padding: const EdgeInsets.all(4),
                onPressed: onDeletePressed,
                icon: const Icon(
                  Iconsax.trash,
                  size: 18,
                  color: FColors.error,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
