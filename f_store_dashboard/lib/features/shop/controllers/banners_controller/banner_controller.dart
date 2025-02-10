import 'package:f_store_dashboard/data/abstract/base_data_table_controller.dart';
import 'package:f_store_dashboard/data/repositories/banner_repository/banner_repository.dart';
import 'package:f_store_dashboard/features/shop/models/banner_model/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends FBaseController<BannerModel> {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return item.targetScreen.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(BannerModel item) {
    return _bannerRepository.deleteBanner(item.id);
  }

  @override
  Future<List<BannerModel>> fetchItems() async {
    return await _bannerRepository.getAllBanners();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending,
        (BannerModel banner) => banner.targetScreen.toLowerCase());
  }
}
