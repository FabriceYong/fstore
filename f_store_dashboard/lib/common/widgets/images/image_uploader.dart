import 'dart:typed_data';

import 'package:f_store_dashboard/common/widgets/icons/circular_icon.dart';
import 'package:f_store_dashboard/common/widgets/images/circular_image.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FImageUploader extends StatelessWidget {
  const FImageUploader(
      {super.key,
      this.imageUrl,
      this.memoryImage,
      this.width = 100,
      this.height = 100,
      required this.imageType,
      this.circular = false,
      this.icon = Iconsax.edit_2,
      this.top,
      this.bottom = 0,
      this.right,
      this.left = 0,
      this.onIconButtonPressed});

  /// whether to display the image in a circular shape
  final bool circular;

  /// URL or path of the image to be displayed
  final String? imageUrl;

  /// Type of image to be displayed (network, asset, memory, etc...)
  final ImageType imageType;

  /// Heigh of the uploader widget
  final double height;

  /// Width of the uploader widget
  final double width;

  /// Byte data of the image (for memory images)
  final Uint8List? memoryImage;

  /// Icon to display on the image uploader widget
  final IconData icon;

  /// Offset from the top edge of the widget
  final double? top;

  /// Offset from the bottom edge of the widget
  final double? bottom;

  /// Offset from the left edge of the widget
  final double? left;

  /// Offset from the right edge of the widget
  final double? right;

  /// Callback button for when button is pressed
  final VoidCallback? onIconButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Display the image in either circular or rounded image
        circular
            ? FCircularImage(
                image: imageUrl,
                width: width,
                height: height,
                imageType: imageType,
                memoryImage: memoryImage,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              )
            : FRoundedImage(
                imageType: imageType,
                width: width,
                height: height,
                imageUrl: imageUrl,
                memoryImage: memoryImage,
                backgroundColor: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey
                    : FColors.primaryBackground,
              ),

        /// Display the edit icon on top of the image
        Positioned(
          top: top,
          bottom: bottom,
          right: right,
          left: left,
          child: FCircularIcon(
              icon: icon,
              size: FSizes.md,
              color: FColors.white,
              onPressed: onIconButtonPressed,
              backgroundColor: FColors.primary.withOpacity(.9)),
        )
      ],
    );
  }
}
