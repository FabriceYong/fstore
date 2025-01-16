import 'package:f_store_dashboard/common/widgets/layouts/app_templates/site_layout.dart';
import 'package:f_store_dashboard/features/shop/models/banner_model/banner_model.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/edit_banner/responsive_screens/edit_banner_desktop.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/edit_banner/responsive_screens/edit_banner_mobile.dart';
import 'package:f_store_dashboard/features/shop/screens/banners/edit_banner/responsive_screens/edit_banner_tablet.dart';
import 'package:flutter/material.dart';

class EditBannerScreen extends StatelessWidget {
  const EditBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final banner = BannerModel(imageUrl: '', targetUrl: '', active: '');
    return  FSiteTemplate(
      desktop: EditBannerDesktop(banner: banner),
      tablet: EditBannerTablet(banner: banner),
      mobile: EditBannerMobile(banner: banner),
    );
  }
}
