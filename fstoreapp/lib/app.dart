import 'package:flutter/material.dart';
import 'package:fstoreapp/bindings/general_bindigs.dart';
import 'package:fstoreapp/routes/app_routes.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/text_strings.dart';
import 'package:fstoreapp/utils/theme/theme.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: FTexts.appName,
      themeMode: ThemeMode.system,
      theme: FAppTheme.lightTheme,
      darkTheme: FAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      home: const Scaffold(
        backgroundColor: FColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: FColors.white,
          ),
        ),
      ),
    );
  }
}
