import 'package:f_store_dashboard/data/repositories/authentication/authentication_repository.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/device/device_utility.dart';
import 'package:get/get.dart';

class SidebarController extends GetxController {
  final activeItem = FRoutes.responsiveScreen.obs;
  final hoverItem = ''.obs;

  // change the current active item to the new active item
  void changeActiveItem(String route) => activeItem.value = route;

  // change the hover item to the new hover item
  void changeHoverItem(String route) {
    if (!isActive(route)) hoverItem.value = route;
  }

  bool isActive(String route) => activeItem.value == route;
  bool isHovering(String route) => hoverItem.value == route;

  void menuOnTap(String route) {
    if (route == 'logout') {
      AuthenticationRepository.instance.logout();
    }
    if (!isActive(route)) {
      changeActiveItem(route);

      if (FDeviceUtils.isMobileScreen(Get.context!)) Get.back();

      Get.toNamed(route);
    }
  }
}
