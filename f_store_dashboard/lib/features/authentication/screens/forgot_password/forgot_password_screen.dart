import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/authentication/screens/forgot_password/responsive_screens/forgot_password_desktop_tablet.dart';
import 'package:f_store_dashboard/features/authentication/screens/forgot_password/responsive_screens/forgot_password_mobile.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(useLayout: false, desktop: ForgotPasswordDesktopTablet(), mobile: ForgotPasswordMobile(),);
  }
}