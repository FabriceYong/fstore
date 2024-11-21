import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/features/personalization/controllers/address_controller/address_controller.dart';
import 'package:fstoreapp/features/personalization/screens/addresses/widgets/add_new_address.dart';
import 'package:fstoreapp/features/personalization/screens/addresses/widgets/single_address.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/helpers/cloud_helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: FColors.primary,
        child: const Icon(
          Iconsax.add,
        ),
        onPressed: () => Get.to(
          () => const AddNewAddressScreen(),
        ),
      ),
      appBar: FAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Obx(
            () => FutureBuilder(
              // Use Key to trigger refresh
              key: Key(controller.refreshData.toString()),
              future: controller.getAllUserAddresses(),
              builder: (context, snapshot) {
                /// Helper function: Handle Loader, No Record, Or Error Message
                final response = FCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                // Record Found
                final addresses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    return FSingleAddress(
                      address: addresses[index],
                      onTap: () => controller.selectAddress(addresses[index]),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
