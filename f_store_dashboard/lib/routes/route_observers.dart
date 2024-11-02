import 'package:f_store_dashboard/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

class FRouteObservers extends GetObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final sidebarController = Get.put(SidebarController());

    if(previousRoute != null){
      for(var routeName in FRoutes.sidebarMenuItems){
        if(previousRoute.settings.name == routeName){
          sidebarController.activeItem.value = routeName;
        }
      }
    }
    // TODO: implement didPop
    super.didPop(route, previousRoute);
  }
}