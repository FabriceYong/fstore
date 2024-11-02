import 'package:fstoreapp/data/repositories/banners/banners_repository.dart';
import 'package:fstoreapp/features/shop/models/banner_model.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

class BannerController extends GetxController{
  static BannerController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }


  /// Fetch Banners
  Future<void> fetchBanners() async {
    try{
      // Show loader while loading banners
      isLoading.value = true;

      // Fetch banners from the data source (firebase, api, etc)
      final _bannerRepository = Get.put(BannersRepository());
      final banners = await _bannerRepository.fetchBanners();

      // update the banners list
      this.banners.assignAll(banners);

    }catch(e){
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}