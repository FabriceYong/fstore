
import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/features/personalization/screens/addresses/widgets/add_new_address.dart';
import 'package:fstoreapp/features/personalization/screens/addresses/widgets/single_address.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Column(
            children: [
              FSingleAddress(selectedAddress: false),
              FSingleAddress(selectedAddress: true),
              FSingleAddress(selectedAddress: false),
              FSingleAddress(selectedAddress: false),
            ],
          ),
        ),
      ),
    );
  }
}
