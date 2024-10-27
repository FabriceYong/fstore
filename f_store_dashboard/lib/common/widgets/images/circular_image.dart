import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:f_store_dashboard/common/widgets/schimmers/shimmer_effect.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FCircularImage extends StatelessWidget {
  const FCircularImage(
      {super.key,
      this.width = 56,
      this.height = 56,
      this.overlayColor,
      this.memoryImage,
      this.file,
      this.imageType = ImageType.asset,
      this.backgroundColor,
      this.image,
      this.fit = BoxFit.cover,
      this.isNetworkImage = false,
      this.padding = FSizes.sm});

  final BoxFit? fit;
  final String? image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;
  final Uint8List? memoryImage;
  final File? file;
  final ImageType imageType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        // IF image background color is null then switch it to light and dark mode color design
        color: backgroundColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white),
        borderRadius: BorderRadius.circular(width >= height ? width : height),
      ),
      child: _buildImageWidget(),
    );
  }

  Widget _buildImageWidget() {
    Widget imageWidget;

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(width >= height ? width : height),
      child: imageWidget,
    );
  }

  Widget _buildNetworkImage() {
    if (image != null) {
      // Use CachedNetworkImage for efficient loading and caching of network images /// Not Working in Web but just for loading
      return CachedNetworkImage(
        fit: fit,
        color: overlayColor,
        imageUrl: image!,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            const FShimmerEffect(width: 55, height: 55),
      );
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }

  Widget _buildMemoryImage() {
    if (memoryImage != null) {
      // Display image from memory using Image Widget
      return Image(
        image: MemoryImage(memoryImage!),
        fit: fit,
        color: overlayColor,
      );
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }

  Widget _buildFileImage() {
    if (file != null) {
      // Display image from assets using Image Widget
      return Image(
        fit: fit,
        color: overlayColor,
        image: FileImage(file!),
      );
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }

  Widget _buildAssetImage() {
    if (image != null) {
      // Display image from the assets folder using the AssetImage Widget
      return Image(
        fit: fit,
        color: overlayColor,
        image: AssetImage(image!),
      );
    } else {
      // Return an empty container if no image is provided
      return Container();
    }
  }
}
