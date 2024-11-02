import 'package:f_store_dashboard/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ResetPasswordMobile extends StatelessWidget {
  const ResetPasswordMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(FSizes.defaultSpace),
          child: FResetPasswordWidget(),
        ),
      ),
    );
  }
}
