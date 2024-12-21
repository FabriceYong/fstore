import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:get/get.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  //Rx Observables for the selected thumbnail image
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  // List to store additional product images
  List<String> additionalProductImageUrls = <String>[].obs;

  /// Pick Thumbnail image from media
  void selectThumbnailImage() async {
    try {
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImageFromMedia();

      // Handle the selected Images
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Set the selected image to the main image or perform any other action
        ImageModel selectedImage = selectedImages.first;

        // Update the main image using the selected image
        selectedThumbnailImageUrl.value = selectedImage.url;
      }
    } catch (e) {
      print(e);
    }
  }

  /// Pick multiple images from media
  void selectMultipleImages() async {
    try {
      final controller = Get.put(MediaController());
      final selectedImages = await controller.selectImageFromMedia(
          multipleSelection: true, selectedUrls: additionalProductImageUrls);

      // Handle the selected Images
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Update the additional images list with the selected images
        additionalProductImageUrls
            .assignAll(selectedImages.map((image) => image.url));
      }
    } catch (e) {
      print(e);
    }
  }

  ///Function to remove product image
  Future<void> removeImage(int index) async {
    additionalProductImageUrls.removeAt(index);
    update();
  }
}
