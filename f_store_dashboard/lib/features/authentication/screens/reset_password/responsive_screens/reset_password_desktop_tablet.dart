import 'package:f_store_dashboard/common/widgets/layouts/app_templates/login_template.dart';
import 'package:f_store_dashboard/features/authentication/screens/reset_password/widgets/reset_password_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResetPasswordDesktopTablet extends StatelessWidget {
  const ResetPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const FLoginTemplate(
      child: FResetPasswordWidget(),
    );
  }
}
