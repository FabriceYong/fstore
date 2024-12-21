import 'package:f_store_dashboard/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FLoaderAnimation extends StatelessWidget {
  const FLoaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Lottie.asset(FImages.loadingJuggleAnimation, height: 200, width: 200),
    );
  }
}
