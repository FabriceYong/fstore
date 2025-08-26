import 'package:f_store_dashboard/features/authentication/controllers/login_controller.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:f_store_dashboard/utils/constants/text_strings.dart';
import 'package:f_store_dashboard/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FLoginForm extends StatelessWidget {
  const FLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: FSizes.spaceBtwSections),
        child: Column(
          children: [
            // EMAIL
            TextFormField(
              validator: (email) => FValidator.validateEmail(email),
              controller: controller.email,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: FTexts.email),
            ),
            const Gap(FSizes.spaceBtwInputFields),
            Obx(
              () => TextFormField(
                validator: (password) =>
                    FValidator.validateEmptyText('Password', password),
                controller: controller.password,
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: FTexts.password,
                  suffixIcon: IconButton(
                    icon: Icon(controller.hidePassword.value == true
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                    onPressed: () {
                      controller.hidePassword.value =
                          !controller.hidePassword.value;
                    },
                  ),
                ),
              ),
            ),
            const Gap(FSizes.spaceBtwInputFields / 2),

            // REMEMBER ME
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) {
                          controller.rememberMe.value = value!;
                        },
                      ),
                      const Text(FTexts.rememberMe),
                    ],
                  ),

                  /// FORGOT PASSWORD
                  TextButton(
                    onPressed: () {
                      Get.toNamed(FRoutes.forgotPassword);
                    },
                    child: const Text(
                      FTexts.forgotPassword,
                    ),
                  )
                ],
              ),
            ),
            const Gap(FSizes.spaceBtwInputFields),

            //LOGIN BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: FColors.primary,
                  padding:
                      const EdgeInsets.symmetric(vertical: FSizes.lg * .75),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(FSizes.defaultSpace / 2),
                  ),
                ),
                onPressed: () => controller.login(),
                // child: const Text('Register Admin'),
                child: const Text('Login'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
