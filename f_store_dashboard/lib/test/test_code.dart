import 'package:f_store_dashboard/common/widgets/containers/rounded_container.dart';
import 'package:f_store_dashboard/common/widgets/responsive/screens/desktop_layout.dart';
import 'package:f_store_dashboard/common/widgets/responsive/screens/mobile_layout.dart';
import 'package:f_store_dashboard/common/widgets/responsive/screens/tablet_layout.dart';
import 'package:f_store_dashboard/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

/// DEFAULT NAVIGATION AND GET NAVIGATION
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.grey.shade200,
        title: const Text('First Screen'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_circle_left,
            size: 28,
            color: Theme.of(context).brightness == Brightness.dark
                ? FColors.white
                : FColors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Simple Navigation: Default Flutter Navigation VS GetX Navigation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SecondScreen();
                    }));
                  },
                  child: const Text('Default Navigation')),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const SecondScreen()),
                child: const Text('GetX Navigation'),
              ),
            ),

            /// NAMED NAVIGATION
            const SizedBox(
              height: 50,
            ),
            const Divider(),
            const Text(
                'Named Navigation, Flutter Default Navigator VS GetX Navigator ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/second-screen'),
                child: const Text('Default Navigation'),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/second-screen'),
                child: const Text('GetX Navigation'),
              ),
            ),

            // PASSING DATA
            const SizedBox(
              height: 50,
            ),
            const Divider(),
            const Text(
              'Pass Data between screens -- GetX',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/second-screen',
                    arguments: 'GetX is run from CwF'),
                child: const Text('GetX pass Data'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(
                    '/second-screen?device=phone&id=3432&name=Fabrice'),
                child: const Text('Pass Data in URL'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Get.toNamed('/second-screen/1234'),
                child: const Text('Pass User ID as parameter'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(
                    '/second-screen?device=phone&id=3432&name=Fabrice',
                    arguments: 'GetX is run from CwF'),
                child: const Text('Pass Data in URL with Arguments'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(
                  '/second-screen?device=phone&id=3432&name=Fabrice',
                  arguments: 'GetX is run from CwF',
                ),
                child: const Text('Pass Data in URL with arguments'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// SECOND SCREEN
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900
            : Colors.grey.shade200,
        foregroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        title: Text(Get.arguments ?? 'Second Screen'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_circle_left,
            size: 28,
            color: Theme.of(context).brightness == Brightness.dark
                ? FColors.white
                : FColors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(Get.arguments ?? 'Second Screen'),
            Text('Device = ${Get.parameters['device'] ?? 'Device Name'}'),
            Text('ID = ${Get.parameters['id'] ?? 'Device ID'}'),
            Text('Name = ${Get.parameters['name'] ?? 'User Name'}'),
            Text('Name = ${Get.parameters['userId'] ?? 'User Name'}'),
          ],
        ),
      ),
    );
    // body: const FSiteTemplate(
    //   desktop: Desktop(),
    //   tablet: Tablet(),
    //   mobile: Mobile(),
    // ));
  }
}

/// RESPONSIVE DESIGN
class ResponsiveDesign extends StatelessWidget {
  const ResponsiveDesign({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });

  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: LayoutBuilder(builder: (_, constraints) {
        if (constraints.maxWidth > 1300) {
          return DesktopLayout(
            body: desktop,
          );
        } else if (constraints.maxWidth < 1300 && constraints.maxWidth >= 750) {
          return TabletLayout(
            body: tablet,
          );
        } else {
          return MobileLayout(
            body: mobile,
          );
        }
      }),
    );
  }
}

/// DESKTOP APP FOR RESPONSIVE DESIGN
class Desktop extends StatelessWidget {
  const Desktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: FRoundedContainer(
                    backgroundColor: Colors.blue.withOpacity(.2),
                    height: 450,
                    child: const Center(
                      child: Text('Box 1'),
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    FRoundedContainer(
                        backgroundColor: Colors.blueGrey.withOpacity(.2),
                        height: 215,
                        child: const Center(
                          child: Text('Box 2'),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FRoundedContainer(
                              backgroundColor: Colors.orange.withOpacity(.2),
                              height: 215,
                              child: const Center(
                                child: Text('Box 3'),
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: FRoundedContainer(
                              backgroundColor:
                                  Colors.deepOrange.withOpacity(.2),
                              height: 225,
                              child: const Center(
                                child: Text('Box 4'),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: FRoundedContainer(
                    backgroundColor: Colors.purple.withOpacity(.2),
                    height: 300,
                    child: const Center(
                      child: Text('Box 5'),
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: FRoundedContainer(
                    backgroundColor: Colors.brown.withOpacity(.2),
                    height: 300,
                    child: const Center(
                      child: Text('Box 6'),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// TABLET APP FOR RESPONSIVE DESIGN
class Tablet extends StatelessWidget {
  const Tablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: FRoundedContainer(
                    backgroundColor: Colors.blue.withOpacity(.2),
                    height: 450,
                    child: const Center(
                      child: Text('Box 1'),
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    FRoundedContainer(
                        backgroundColor: Colors.blueGrey.withOpacity(.2),
                        height: 215,
                        child: const Center(
                          child: Text('Box 2'),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: FRoundedContainer(
                              backgroundColor: Colors.orange.withOpacity(.2),
                              height: 215,
                              child: const Center(
                                child: Text('Box 3'),
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: FRoundedContainer(
                              backgroundColor:
                                  Colors.deepOrange.withOpacity(.2),
                              height: 225,
                              child: const Center(
                                child: Text('Box 4'),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          FRoundedContainer(
              backgroundColor: Colors.purple.withOpacity(.2),
              height: 250,
              width: double.infinity,
              child: const Center(
                child: Text('Box 5'),
              )),
          const SizedBox(
            height: 20,
          ),
          FRoundedContainer(
              backgroundColor: Colors.brown.withOpacity(.2),
              height: 250,
              width: double.infinity,
              child: const Center(
                child: Text('Box 6'),
              ))
        ],
      ),
    );
  }
}

// MOBILE APP FOR RESPONSIVE DESIGN
class Mobile extends StatelessWidget {
  const Mobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FRoundedContainer(
              backgroundColor: Colors.blue.withOpacity(.2),
              height: 450,
              child: const Center(
                child: Text('Box 1'),
              )),
          const SizedBox(
            height: 20,
          ),
          FRoundedContainer(
              backgroundColor: Colors.blueGrey.withOpacity(.2),
              height: 215,
              child: const Center(
                child: Text('Box 2'),
              )),
          const SizedBox(
            height: 20,
          ),
          FRoundedContainer(
              backgroundColor: Colors.orange.withOpacity(.2),
              height: 215,
              child: const Center(
                child: Text('Box 3'),
              )),
          const SizedBox(
            height: 20,
          ),
          FRoundedContainer(
              backgroundColor: Colors.deepOrange.withOpacity(.2),
              height: 225,
              child: const Center(
                child: Text('Box 4'),
              )),
          const SizedBox(
            height: 20,
          ),
          FRoundedContainer(
              backgroundColor: Colors.purple.withOpacity(.2),
              height: 300,
              child: const Center(
                child: Text('Box 5'),
              )),
          const SizedBox(
            height: 20,
          ),
          FRoundedContainer(
              backgroundColor: Colors.brown.withOpacity(.2),
              height: 300,
              child: const Center(
                child: Text('Box 6'),
              ))
        ],
      ),
    );
  }
}

// ROUNDED CONTAINER
// class FRoundedContainer extends StatelessWidget {
//   const FRoundedContainer(
//       {super.key,
//       this.width,
//       this.height,
//       this.backgroundColor,
//       required this.child});
//   final double? width;
//   final double? height;
//   final Color? backgroundColor;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20), color: backgroundColor),
//       child: child,
//     );
//   }
// }
