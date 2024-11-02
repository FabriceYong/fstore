import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:fstoreapp/utils/constants/colors.dart';

class FPrimaryHeaderContainer extends StatelessWidget {
  const FPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FCurvedEdgesWidget(
      child: Container(
        color: FColors.primary,
        child: Stack(
          children: [
            /// -- Custom Shapes
            Positioned(
              top: -150,
              right: -150,
              child: FCircularContainer(
                  backgroundColor: FColors.textWhite.withOpacity(.1)),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: FCircularContainer(
                  backgroundColor: FColors.textWhite.withOpacity(.1)),
            ),
            child // For Adding children inside the curved edges widget
          ],
        ),
      ),
    );
  }
}
