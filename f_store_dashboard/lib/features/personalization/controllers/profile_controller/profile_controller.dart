import 'package:f_store_dashboard/data/models/user_model.dart';
import 'package:f_store_dashboard/data/repositories/user/user_repository.dart';
import 'package:f_store_dashboard/features/media/controllers/media_controller.dart';
import 'package:f_store_dashboard/features/media/models/image_model.dart';
import 'package:f_store_dashboard/utils/helpers/network_manager.dart';
import 'package:f_store_dashboard/utils/loaders/full_screen_loader.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  @override
  void onInit() {
    // Fetch user details on initialization
    fetchUserDetails();
    super.onInit();
  }

  final isLoading = false.obs;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final _userRepository = Get.put(UserRepository());
  final formKey = GlobalKey<FormState>();

  Rx<UserModel> user = UserModel.empty().obs;

  Future<UserModel> fetchUserDetails() async {
    try{
      isLoading(true);
      final user = await _userRepository.fetchAdminDetails();
      this.user.value = user;

      firstName.text = user.firstName;
      lastName.text = user.lastName;
      email.text = user.email;
      phoneNumber.text = user.phoneNumber;

      return user;
    }catch(e){
      print(e);
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString()); 
      return UserModel.empty();
    }finally{
      isLoading.value = false;
    }
  }

  void updateProfilePicture() async {
    try{
      final MediaController mediaController = Get.put(MediaController());
      final List<ImageModel>? selectedImages = await mediaController.selectImageFromMedia();

      if(selectedImages != null && selectedImages.isNotEmpty){
        // Set the selected image to the  main image or perform any other action;
        ImageModel selectedImage = selectedImages.first;

        // Update profile in firestore
        await _userRepository.updateSingleField({'ProfilePicture': selectedImage.url});

        // Update the main Image using the Url
        user.value.profilePicture = selectedImage.url;
        user.refresh();
        Snackbars.successSnackbar(title: 'Congratulations!', message: 'Your profile picture has been updated');
      }
      isLoading.value = false;
    }catch(e){
      print(e);
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  void updateUserProfile() async {
    try{
      isLoading(true);

      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        FFullScreenLoader.stopLoading();
        Snackbars.errorSnackBar(title: 'Ohh Snap!', message: 'No Internet Connection!');
        return;
      }

      if(!formKey.currentState!.validate()){
        FFullScreenLoader.stopLoading();
        return;
      }

      user.value.firstName = firstName.text.trim();
      user.value.lastName = lastName.text.trim();
      user.value.email = email.text.trim();
      user.value.phoneNumber = phoneNumber.text.trim();

      await _userRepository.updateUserProfile(user.value);
      user.refresh();

      Snackbars.successSnackbar(title: 'Congratulations!', message: 'Your user profile has been updated');
    }catch(e){
      print(e);
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}