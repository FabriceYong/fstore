import 'package:f_store_dashboard/common/widgets/layouts/headers/headers.dart';
import 'package:f_store_dashboard/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  DesktopLayout({super.key, this.body});

  final Widget? body;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      body: Row(
        children: [
          const Expanded(flex: 1, child: FSidebar()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                // HEADER
                FHeader(scaffoldKey: scaffoldKey),

                // BODY
                Expanded(child: body ?? const SizedBox()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
