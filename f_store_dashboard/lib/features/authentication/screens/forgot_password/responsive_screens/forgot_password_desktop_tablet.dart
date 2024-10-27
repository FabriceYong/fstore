import 'package:f_store_dashboard/common/widgets/layouts/app_templates/login_template.dart';
import 'package:f_store_dashboard/features/authentication/screens/forgot_password/widgets/header_and_form.dart';
import 'package:flutter/material.dart';

class ForgotPasswordDesktopTablet extends StatelessWidget {
  const ForgotPasswordDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return const FLoginTemplate(child: FHeaderAndForm());
  }
}
