import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FTableActionButtons extends StatelessWidget {
  const FTableActionButtons(
      {super.key,
      this.view = false,
      this.edit = true,
      this.delete = true,
      this.onViewPressed,
      this.onEditPressed,
      this.onDeletePressed});

  /// Flag to determine whether the view button is enabled
  final bool view;

  /// Flag to determin whether the edit button is enabled
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
      children: [
        if (view)
          IconButton(
            onPressed: onViewPressed,
            icon: const Icon(
              Iconsax.eye,
              color: FColors.darkerGrey,
            ),
          ),
        if (edit)
          IconButton(
              onPressed: onEditPressed,
              icon: const Icon(
                Iconsax.pen_add,
                color: FColors.primary,
              )),
        if (delete)
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(
              Iconsax.trash,
              color: FColors.error,
            ),
          )
      ],
    );
  }
}
