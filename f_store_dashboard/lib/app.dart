import 'package:f_store_dashboard/bindings/general_bindings.dart';
import 'package:f_store_dashboard/routes/app_routes.dart';
import 'package:f_store_dashboard/routes/routes.dart';
import 'package:f_store_dashboard/utils/constants/text_strings.dart';
import 'package:f_store_dashboard/utils/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: FTexts.appName,
      themeMode: ThemeMode.system,
      theme: FAppTheme.lightTheme,
      darkTheme: FAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),

      // Routes
      getPages: FAppRoutes.pages,
      initialRoute: FRoutes.dashboard,
      unknownRoute: GetPage(
        name: '/page-not-found',
        page: () => const Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        ),
      ),
    );
  }
}

// class ResponsiveDesignScreen extends StatelessWidget {
//   const ResponsiveDesignScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//         body: FSiteTemplate(
//       desktop: Desktop(),
//       tablet: Tablet(),
//       mobile: Mobile(),
//     ));
//   }
// }
