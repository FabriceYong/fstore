import 'package:clipboard/clipboard.dart';
import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

class ImagePopUp extends StatelessWidget {
  const ImagePopUp({super.key, required this.image});

  final ImageModel image;

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Dialog(
      alignment: Alignment.center,
      // Define the shape of the dialog
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FSizes.borderRadiusLg)),
      child: FRoundedContainer(
        // Set the width of the rounded container based on the screen size
        width: FDeviceUtils.isDesktopScreen(context)
            ? MediaQuery.of(context).size.width * .4
            : double.infinity,
        padding: const EdgeInsets.all(FSizes.spaceBtwItems),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the image with an option to close the dialog
              SizedBox(
                child: Stack(
                  children: [
                    // Display the image with rounded container
                    FRoundedContainer(
                      backgroundColor: FHelperFunctions.isDarkMode(context)
                          ? FColors.black
                          : FColors.grey,
                      child: FRoundedImage(
                        imageType: ImageType.network,
                        applyImageRadius: true,
                        imageUrl: image.url,
                        height: MediaQuery.of(context).size.height * .4,
                        width: FDeviceUtils.isDesktopScreen(context)
                            ? MediaQuery.of(context).size.width * .4
                            : double.infinity,
                      ),
                    ),

                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Iconsax.close_circle),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey.withOpacity(.5)
                    : Colors.grey.shade300.withOpacity(.5),
              ),
              const Gap(FSizes.spaceBtwItems),
              // Display various metadata about the image
              // Includes image name, path, type sized, creation and modification dates and url
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Image Name',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  Expanded(
                    flex: 3,
                    child: Text(
                      image.filename,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                ],
              ),
              Divider(
                color: FHelperFunctions.isDarkMode(context)
                    ? FColors.darkerGrey.withOpacity(.5)
                    : Colors.grey.shade300.withOpacity(.5),
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Image URL',
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        image.url,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => FlutterClipboard.copy(image.url).then(
                          (value) => Snackbars.customToast(
                              message: 'URL copied to clipboard')),
                      child: const Text('Copy URL'),
                    ),
                  )
                ],
              ),
              const Gap(FSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextButton(
                        onPressed: () => MediaController.instance
                            .removeCloudImageConfirmation(image),
                        child: const Text(
                          'Delete Image',
                          style: TextStyle(color: Colors.red),
                        )),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
