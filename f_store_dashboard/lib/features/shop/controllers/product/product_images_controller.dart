import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/features/shop/models/product/product_variations_model.dart';
import 'package:get/get.dart';

class ProductImagesController extends GetxController {
  static ProductImagesController get instance => Get.find();

  //Rx Observables for the selected thumbnail image
  Rx<String?> selectedThumbnailImageUrl = Rx<String?>(null);

  // List to store additional product images
  RxList<String> additionalProductImageUrls = <String>[].obs;

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
  void selectMultipleProductImages() async {
    try {
      final controller = Get.put(MediaController());
      final selectedImages = await controller.selectImageFromMedia(
          multipleSelection: true, selectedUrls: additionalProductImageUrls);

      // Handle the selected Images
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Update the additional images list with the selected images
        additionalProductImageUrls.assignAll(
            selectedImages.map((image) => image.url)); // Use addAll to append
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

  /// Pick Variation image from media
  void selectVariationImage(ProductVariationsModel variation) async {
    try {
      final controller = Get.put(MediaController());
      List<ImageModel>? selectedImages =
          await controller.selectImageFromMedia();

      // Handle the selected Images
      if (selectedImages != null && selectedImages.isNotEmpty) {
        // Set the selected image to the variation image
        ImageModel selectedImage = selectedImages.first;

        // Update the variation image using the selected image URL
        variation.image.value = selectedImage.url;
        update(); // Notify listeners about the change
      }
    } catch (e) {
      print(e);
    }
  }
}
