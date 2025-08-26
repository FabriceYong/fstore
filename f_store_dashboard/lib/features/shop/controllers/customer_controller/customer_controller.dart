import 'package:f_store_dashboard/data/abstract/base_data_table_controller.dart';
import 'package:f_store_dashboard/data/models/user_model.dart';
import 'package:f_store_dashboard/data/repositories/user/user_repository.dart';
import 'package:get/get.dart';

class CustomerController extends FBaseController<UserModel> {
  static CustomerController get instance => Get.find();

  final _customerRepository = Get.put(UserRepository());

  @override
  bool containsSearchQuery(UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
   return await _customerRepository.deleteUser(item.id ?? '');
  }

  @override
  Future<List<UserModel>> fetchItems() async {
    return await _customerRepository.fetchAllUsers();
  }
  
  void sortByName(sortColumnIndex, ascending) {
    sortByProperty(sortColumnIndex, ascending, (UserModel user) => user.fullName.toString().toLowerCase());
  }
}