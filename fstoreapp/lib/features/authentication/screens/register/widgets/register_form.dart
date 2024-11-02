import 'package:flutter/material.dart';
import 'package:fstoreapp/features/authentication/controllers/signup_controller/signup_controller.dart';
import 'package:fstoreapp/features/authentication/screens/register/widgets/terms_and_conditions_checkbox.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/validators/validation.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FRegisterForm extends StatelessWidget {
  const FRegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                    expands: false,
                    controller: controller.firstName,
                    validator: (firstName) =>
                        FValidator.validateEmptyString('First Name', firstName),
                    decoration: const InputDecoration(
                      labelText: FTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    )),
              ),
              const Gap(FSizes.spaceBtwInputFields),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (lastName) =>
                      FValidator.validateEmptyString('Last Name', lastName),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: FTexts.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              )
            ],
          ),
          const Gap(FSizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.username,
            validator: (username) =>
                FValidator.validateEmptyString('Username', username),
            decoration: const InputDecoration(
              labelText: FTexts.username,
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const Gap(FSizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.email,
            validator: (email) => FValidator.validateEmail(email),
            decoration: const InputDecoration(
              labelText: FTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
          const Gap(FSizes.spaceBtwInputFields),
          TextFormField(
            controller: controller.phoneNumber,
            validator: (phoneNumber) =>
                FValidator.validatePhoneNumber(phoneNumber),
            decoration: const InputDecoration(
              labelText: FTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const Gap(FSizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              validator: (password) => FValidator.validatePassword(password),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: FTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value == true
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),
          const Gap(FSizes.spaceBtwSections),

          /// Terms and Conditions
          const FTermsAndConditionsCheckbox(),

          // Button
          const Gap(FSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(FTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
