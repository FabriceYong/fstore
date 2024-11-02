import 'package:f_store_dashboard/data/repositories/authentication/models/user_model.dart';
import 'package:f_store_dashboard/data/repositories/user/user_repository.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final UserRepository userRepository = Get.put(UserRepository());
  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  RxBool imageUploading = false.obs;

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;
      return user;
    } catch (e) {
      Snackbars.errorSnackBar(
          title: 'Something went wrong.', message: e.toString());
      return UserModel.empty();
    }
  }

  /// [Upload Profile Image] -- UPLOAD PROFILE IMAGE
  Future<void> uploadProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 512,
        maxHeight: 512,
      );

      /// Upload Image
      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImage(
            'Users/Image/profilePicture', image);

        /// Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        imageUploading.value = false;
        Snackbars.successSnackbar(
            title: 'Image Added Successfully',
            message: 'Your profile picture has been updated successfully');
      }
    } catch (e) {
      imageUploading.value = false;
      Snackbars.errorSnackBar(
          title: 'Ohh Snap!', message: 'Something went wrong: $e');
      print(e);
    }
  }
}
