import 'dart:typed_data';

import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/images/rounded_image.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/features/media/screens/widgets/folder_dropdown.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/enums.dart';
import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:f_store_dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FMediaUploaderWidget extends StatelessWidget {
  const FMediaUploaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaController = MediaController.instance;
    return Obx(
      () => mediaController.showImagesUploaderSection.value
          ? Column(
              children: [
                /// Drag and Drop area
                FRoundedContainer(
                  height: 250,
                  showBorder: true,
                  borderColor: FHelperFunctions.isDarkMode(context)
                      ? FColors.dark
                      : FColors.borderPrimary,
                  backgroundColor: FHelperFunctions.isDarkMode(context)
                      ? FColors.black
                      : FColors.primaryBackground,
                  padding: const EdgeInsets.all(FSizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DropzoneView(
                              mime: const ['image/jpeg', 'image/png'],
                              cursor: CursorType.Default,
                              operation: DragOperation.copy,
                              onLoaded: () => print('Zone Loaded'),
                              onError: (ev) => print('Zone Error: $ev'),
                              onHover: () => print('Zone Hovered'),
                              onLeave: () => print('Zone Left'),
                              onCreated: (controller) => mediaController
                                  .dropzoneController = controller,
                              onDropInvalid: (ev) =>
                                  print('Zone Invalid MIME: $ev'),
                              onDropFile: (file) async {
                                // if (file is html.File) {
                                final bytes = await mediaController
                                    .dropzoneController
                                    .getFileData(file);
                                final image = ImageModel(
                                    url: '',
                                    file: file,
                                    folder: '',
                                    filename: file.name,
                                    localImageToDisplay:
                                        Uint8List.fromList(bytes));

                                mediaController.selectedImagesToUpload
                                    .add(image);
                              },
                              //   else if (file is String) {
                              //     print('Zone drop: $file');
                              //   } else {
                              //     print(
                              //         'Zone unknown type: ${file.runtimeType}');
                              //   }
                              // },
                              onDropFiles: (ev) async {
                                print('Zone Drop Multiple: $ev');
                              },
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  FImages.defaultMultiImageIcon,
                                  color: FHelperFunctions.isDarkMode(context)
                                      ? FColors.white
                                      : FColors.black,
                                  width: 50,
                                  height: 50,
                                ),
                                const Gap(FSizes.spaceBtwItems),
                                const Text('Drag and Drop Images here'),
                                const Gap(FSizes.spaceBtwItems),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                FSizes.sm))),
                                    onPressed: () =>
                                        mediaController.selectedLocalImages(),
                                    child: const Text('Select Images'))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Gap(FSizes.spaceBtwItems),

                /// Heading & Locally Selected Images
                if (mediaController.selectedImagesToUpload.isNotEmpty)
                  FRoundedContainer(
                    backgroundColor: FHelperFunctions.isDarkMode(context)
                        ? FColors.black
                        : FColors.white,
                    padding: const EdgeInsets.all(FSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Folders Dropdown
                            Row(
                              children: [
                                // Folders Dropdown
                                Text(
                                  'Select Folder',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const Gap(FSizes.spaceBtwItems),
                                FFolderDropdownWidget(
                                  onChanged: (MediaCategory? category) {
                                    if (category != null) {
                                      mediaController.selectedPath.value =
                                          category;
                                    }
                                  },
                                )
                              ],
                            ),

                            Row(
                              children: [
                                TextButton(
                                    onPressed: () => mediaController
                                        .selectedImagesToUpload
                                        .clear(),
                                    child: const Text('Remove All')),
                                const Gap(FSizes.spaceBtwItems),
                                FDeviceUtils.isMobileScreen(context)
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: FSizes.buttonWidth,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(FSizes.sm),
                                              ),
                                            ),
                                          ),
                                          onPressed: () => mediaController
                                              .uploadImagesConfirmationBox(),
                                          child: const Text('Upload'),
                                        ),
                                      )
                              ],
                            ),
                          ],
                        ),
                        const Gap(FSizes.spaceBtwItems),

                        /// Images
                        Obx(
                          () => Wrap(
                            alignment: WrapAlignment.start,
                            spacing: FSizes.spaceBtwItems / 2,
                            runSpacing: FSizes.spaceBtwItems / 2,
                            children: mediaController.selectedImagesToUpload
                                .where((image) =>
                                    image.localImageToDisplay != null)
                                .map((element) {
                              return FRoundedImage(
                                width: 100,
                                height: 100,
                                padding: FSizes.sm,
                                imageType: ImageType.memory,
                                memoryImage: element.localImageToDisplay,
                                // overlayColor:
                                //     FHelperFunctions.isDarkMode(context)
                                //         ? FColors.white
                                //         : FColors.black,
                                backgroundColor:
                                    FHelperFunctions.isDarkMode(context)
                                        ? FColors.black
                                        : Colors.white,
                              );
                            }).toList(),
                          ),
                        ),

                        const Gap(FSizes.spaceBtwItems),
                        FDeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        FSizes.sm,
                                      ),
                                    ),
                                  ),
                                  onPressed: () => mediaController
                                      .uploadImagesConfirmationBox(),
                                  child: const Text('Upload'),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  )
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
