import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_store_dashboard/common/widgets/schimmers/shimmer_effect.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FRoundedImage extends StatelessWidget {
  const FRoundedImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.file,
    this.memoryImage,
    this.overlayColor,
    required this.imageType,
    this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding = FSizes.sm,
    this.onPressed,
    this.isNetWorkImage = false,
    this.borderRadius = FSizes.md,
    this.margin,
  });

  final double width, height, borderRadius;
  final String? imageUrl;
  final bool applyImageRadius, isNetWorkImage;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final double? padding;
  final VoidCallback? onPressed;
  final double? margin;
  final File? file;
  final Uint8List? memoryImage;
  final Color? overlayColor;
  final ImageType imageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin != null ? EdgeInsets.all(margin!) : null,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget = Container();

    switch (imageType) {
      case ImageType.network:
        imageWidget = _buildNetworkImage();
        break;
      case ImageType.memory:
        imageWidget = _buildMemoryImage();
        break;
      case ImageType.file:
        imageWidget = _buildFileImage();
        break;
      case ImageType.asset:
        imageWidget = _buildAssetImage();
        break;
    }

    // Apply ClipRRect directly to the image widget
    return ClipRRect(
      borderRadius: applyImageRadius
          ? BorderRadius.circular(borderRadius)
          : BorderRadius.zero,
      child: imageWidget,
    );
  }

  // Function to build the Memory image Widget
  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      return Image(
        fit: fit,
        // Display Image from memory using the Image Widget
        image: MemoryImage(memoryImage!),
        color: overlayColor,
      );
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }

  // Network image Type
  Widget _buildNetworkImage() {
    if (imageUrl != null) {
      // Use CachedNetworkImage for efficient loading and caching of network images // Not working in Web but just for loading
      return CachedNetworkImage(
        fit: fit,
        color: overlayColor,
        imageUrl: imageUrl!,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            FShimmerEffect(width: width, height: height),
      );
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }

  // File image Type
  Widget _buildFileImage() {
    if (file != null) {
      // Display image from assets using image widget
      return Image(
        fit: fit,
        image: FileImage(file!),
        color: overlayColor,
      );
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }

  // Asset Image Type
  Widget _buildAssetImage() {
    if (imageUrl != null) {
      // Display image from assets using Image widget
      return Image(
        fit: fit,
        image: AssetImage(imageUrl!),
        color: overlayColor,
      );
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }
}
