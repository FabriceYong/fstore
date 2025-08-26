import 'package:f_store_dashboard/common/widgets/layouts/app_templates/login_template.dart';
import 'package:f_store_dashboard/features/authentication/screens/login/widgets/login_form.dart';
import 'package:f_store_dashboard/features/authentication/screens/login/widgets/login_header.dart';
import 'package:flutter/material.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return  const FLoginTemplate(
      child: Column(
        children: [
          // Header
          FLoginHeader(),

          // FORM
          FLoginForm()
        ],
      ),
    );
  }
}
