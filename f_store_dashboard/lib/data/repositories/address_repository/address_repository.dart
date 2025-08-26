import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:f_store_dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:f_store_dashboard/features/shop/models/addresses_model/address_model.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Find User addresses
  Future<List<AddressModel>> fetchUserAddresses(String userId) async {
    try {
      // final userId = Get.find<AuthenticationRepository>().authUser!.uid;
      if (userId.isEmpty) {
        throw 'Could not find user information, try again in a few minutes';
      }

      final results = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .get();

      return results.docs
          .map((documentSnapshot) =>
              AddressModel.fromDocumentSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }

  /// Clear the 'selected' field for all addresses
  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = Get.find<AuthenticationRepository>().authUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'SelectedAddress': selected});
    } catch (e) {
      print(e);
      throw 'Unable to updated your addresses. Please try again later';
    }
  }

  Future<String> addAddress(AddressModel address) async {
    try{  
      final userId = Get.find<AuthenticationRepository>().authUser!.uid;
      final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;
    }catch(e){
      print(e);
      throw 'Something went wrong. Please try again';
    }
  }
}
