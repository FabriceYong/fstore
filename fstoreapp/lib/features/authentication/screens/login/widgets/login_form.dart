import 'package:flutter/material.dart';
import 'package:fstoreapp/features/authentication/controllers/login_controller/login_controller.dart';
import 'package:fstoreapp/features/authentication/screens/password_configuration/forgot_password.dart';
import 'package:fstoreapp/features/authentication/screens/register/register.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/validators/validation.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FLoginForm extends StatelessWidget {
  const FLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
        key: controller.loginFormKey,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: FSizes.spaceBtwSections),
          child: Column(
            children: [
              /// Email
              TextFormField(
                controller: controller.email,
                validator: (email) => FValidator.validateEmail(email),
                decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: FTexts.email),
              ),
              const Gap(FSizes.spaceBtwInputFields),
              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (password) =>
                      FValidator.validatePassword(password),
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Iconsax.password_check),
                      labelText: FTexts.password,
                      suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value
                              ? Iconsax.eye_slash
                              : Iconsax.eye))),
                ),
              ),
              const Gap(FSizes.spaceBtwInputFields / 2),

              /// Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Remember Me
                  Obx(
                    () => Row(
                      children: [
                        Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.rememberMe.value =
                                !controller.rememberMe.value),
                        const Text(FTexts.rememberMe),
                      ],
                    ),
                  ),

                  /// Forgot Password
                  TextButton(
                      onPressed: () =>
                          Get.to(() => const ForgotPasswordScreen()),
                      child: const Text(FTexts.forgetPassword)),
                ],
              ),
              const Gap(FSizes.spaceBtwSections),

              /// Sign In Button
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.login(),
                      child: const Text(FTexts.signIn))),
              const Gap(FSizes.spaceBtwItems),

              /// Create Account Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const RegisterScreen()),
                    child: const Text(FTexts.createAccount)),
              ),
            ],
          ),
        ));
  }
}
