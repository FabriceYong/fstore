import 'package:f_store_dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FRoutesMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Redirect to the login page if the user is not authenticated
    return AuthenticationRepository.instance.isAuthenticated
        ? null
        : const RouteSettings(name: FRoutes.login);
  }
}
