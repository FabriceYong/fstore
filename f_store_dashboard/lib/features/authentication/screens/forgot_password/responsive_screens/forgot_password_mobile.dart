import 'package:f_store_dashboard/features/authentication/screens/forgot_password/widgets/header_and_form.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ForgotPasswordMobile extends StatelessWidget {
  const ForgotPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(FSizes.defaultSpace),
      child: FHeaderAndForm(),
    ));
  }
}
