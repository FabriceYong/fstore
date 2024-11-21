import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';

class FCircularLoader extends StatelessWidget {
  const FCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: FColors.primary,
      ),
    );
  }
}
