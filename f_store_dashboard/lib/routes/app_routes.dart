import 'package:f_store_dashboard/features/shop/screens/dashboard/dashboard_screen.dart';
import 'package:f_store_dashboard/features/authentication/screens/forgot_password/forgot_password_screen.dart';
import 'package:f_store_dashboard/features/authentication/screens/login/login.dart';
import 'package:f_store_dashboard/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/routes/routes_middleware.dart';
import 'package:get/get.dart';

class FAppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: FRoutes.login, page: () => const LoginScreen()),
    GetPage(
        name: FRoutes.forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(
        name: FRoutes.resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(
        name: FRoutes.dashboard,
        page: () => const DashboardScreen(),
        middlewares: [FRoutesMiddleware()])
  ];
}
