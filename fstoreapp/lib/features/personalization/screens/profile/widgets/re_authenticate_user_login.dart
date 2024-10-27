import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/appbar/appbar.dart';
import 'package:fstoreapp/features/personalization/controllers/re_authenticate_user_controller/re_authenticate_user_controller.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/validators/validation.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateUserLogin extends StatelessWidget {
  const ReAuthenticateUserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReAuthenticateUserController());
    return Scaffold(
      appBar: const FAppBar(
        title: Text('Re-Authenticate User'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace / 2),
          child: Form(
            key: controller.reAuthenticateUserFormKey,
            child: Column(
              children: [
                /// Email
                TextFormField(
                  controller: controller.email,
                  validator: (email) => FValidator.validateEmail(email),
                  decoration: const InputDecoration(
                    labelText: FTexts.email,
                    prefixIcon: Icon(Iconsax.direct_right),
                  ),
                ),
                const Gap(FSizes.spaceBtwInputFields),

                /// Password
                Obx(
                  () => TextFormField(
                    controller: controller.password,
                    validator: (password) =>
                        FValidator.validatePassword(password),
                    obscureText: controller.hidePassword.value,
                    decoration: InputDecoration(
                      labelText: FTexts.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                        onPressed: () => controller.hidePassword.value =
                            !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye),
                      ),
                    ),
                  ),
                ),
                const Gap(FSizes.spaceBtwSections),

                /// Verify Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.reAuthenticateEmailAndPasswordUser(),
                    child: const Text('Verify'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
