import 'package:firebase_auth/firebase_auth.dart';
import 'package:fstoreapp/data/models/user_model/user_model.dart';
import 'package:fstoreapp/data/repositories/user/user_repository.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  final profileLoading = false.obs;
  final imageUploading = false.obs;
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;

  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  // Fetch User
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      profileLoading.value = false;
      user(UserModel.empty());
    }
  }

  /// Save user Record from any Registration provider
  Future<void> saveUserDetails(UserCredential? userCredentials) async {
    try {
      // First Update Rx User and then check if user data is already stored. if not store new data
      await fetchUserRecord();

      print(user.value.id);
      if (userCredentials != null) {
        // Convert name to First and Last Name
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username =
            UserModel.generateUserName(userCredentials.user!.displayName ?? '');

        // Map Data
        final userDetails = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          userName: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );

        // Save user data
        await userRepository.saveUserRecord(userDetails);
      }
    } catch (e) {
      Snackbars.errorSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your Profile');
    }
  }

  // Upload User Profile Picture
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      /// Upload Image
      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await UserRepository.instance
            .uploadImage('Users/Image/Profile/', image);

        print('After image upload: $imageUrl');

        /// Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        Snackbars.successSnackbar(
          title: 'Congratulations!',
          message: 'Your Profile Image has been updated',
        );
      }
    } catch (e) {
      Snackbars.errorSnackBar(
          title: 'Oh Snap!', message: 'Something went wrong: $e');
      if (e is FirebaseException) {
        print(
            'Firebase Storage Exception. Code: ${e.code}, Message: ${e.message}');
      } else {
        print('General Error: $e');
      }
    } finally {
      imageUploading.value = false;
    }
  }
}
