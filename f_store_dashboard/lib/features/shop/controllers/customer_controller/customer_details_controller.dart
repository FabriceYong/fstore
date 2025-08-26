import 'package:f_store_dashboard/data/models/user_model.dart';
import 'package:f_store_dashboard/data/repositories/address_repository/address_repository.dart';
import 'package:f_store_dashboard/data/repositories/user/user_repository.dart';
import 'package:f_store_dashboard/features/shop/models/order_model/order_model.dart';
import 'package:f_store_dashboard/utils/popups/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerDetailsController extends GetxController {
  static CustomerDetailsController get instance => Get.find();

  RxBool customersLoading = false.obs;
  RxBool addressLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<bool> selectedRows = <bool>[].obs;
  Rx<UserModel> customer = UserModel.empty().obs;
  final _addressRepository = Get.put(AddressRepository());
  final searchTextController = TextEditingController();
  RxList<OrderModel> allCustomerOrders = <OrderModel>[].obs;
  RxList<OrderModel> filteredCustomerOrders = <OrderModel>[].obs;

  Future<void> getAllCustomerOrders() async {
    try {
      // Show loader while loading categories
      customersLoading.value = true;

      // Fetch customer orders and addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.orders = await Get.find<UserRepository>()
            .fetchUserOrders(customer.value.id!);
      }

      // Update the categories list
      allCustomerOrders.assignAll(customer.value.orders ?? []);

      // Filter featured categories
      filteredCustomerOrders.assignAll(customer.value.orders ?? []);

      // And all rows as false [Not selected] & Toggle when required
      selectedRows.assignAll(List.generate(
          customer.value.orders != null ? customer.value.orders!.length : 0,
          (index) => false));
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh  Snap!', message: e.toString());
    } finally {
      customersLoading.value = false;
    }
  }

  //== Get Customer Addresses
  Future<void> getCustomerAddresses() async {
    try {
      // Show loader while loading categories
      addressLoading.value = true;

      // Fetch customer orders & addresses
      if (customer.value.id != null && customer.value.id!.isNotEmpty) {
        customer.value.addresses =
            await _addressRepository.fetchUserAddresses(customer.value.id!);
      }
    } catch (e) {
      Snackbars.errorSnackBar(title: 'Ohh Snap!', message: e.toString());
    } finally {
      addressLoading.value = false;
    }
  }

  searchQuery(String query) {
    filteredCustomerOrders.assignAll(allCustomerOrders.where((customer) =>
        customer.id.toLowerCase().contains(query.toLowerCase()) ||
        customer.orderDate.toString().contains(query.toLowerCase()) ||
        customer.status.toString().contains(query.toLowerCase())));

        // Notify listeners about the changes
      update();
  }

  sortById(sortColumnIndex, ascending) {
    sortAscending.value = ascending;
    filteredCustomerOrders.sort((a, b) {
      if(ascending) {
        return a.id.toLowerCase().compareTo(b.id.toLowerCase());
      }else {
        return b.id.toLowerCase().compareTo(b.id.toLowerCase());
      }
    });
    this.sortColumnIndex.value = sortColumnIndex;
    update();
  }

  sortByStatus(sortColumnIndex, ascending) {
    sortAscending.value = ascending;
    filteredCustomerOrders.sort((a, b) {
      if(ascending){
       return a.status.toString().toLowerCase().compareTo(b.status.toString().toLowerCase());
      }else {
        return b.status.toString().toLowerCase().compareTo(a.status.toString().toLowerCase());
      }
    });
  }
}
