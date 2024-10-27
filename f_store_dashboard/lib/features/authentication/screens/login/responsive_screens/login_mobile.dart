import 'package:f_store_dashboard/features/authentication/screens/login/widgets/login_form.dart';
import 'package:f_store_dashboard/features/authentication/screens/login/widgets/login_header.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: dark ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(FSizes.defaultSpace),
          child: Column(
            children: [
              /// HEADER
              const FLoginHeader(),

              /// LOGIN FORM
              FLoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
