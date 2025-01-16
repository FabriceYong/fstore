import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/create_banner/responsive_screens/create_banner_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/create_banner/responsive_screens/create_banner_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/create_banner/responsive_screens/create_banner_tablet.dart';
import 'package:flutter/material.dart';

class CreateBannerScreen extends StatelessWidget {
  const CreateBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FSiteTemplate(
      desktop: CreateBannerDesktop(),
      tablet: CreateBannerTablet(),
      mobile: CreateBannerMobile(),
    );
  }
}
