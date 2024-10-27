import 'package:f_store_dashboard/common/widgets/layouts/headers/headers.dart';
import 'package:f_store_dashboard/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class MobileLayout extends StatelessWidget {
  MobileLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      appBar: FHeader(
        scaffoldKey: scaffoldKey,
      ),
      drawer: FSidebar(),
      body: body ?? const SizedBox(),
    );
  }
}
