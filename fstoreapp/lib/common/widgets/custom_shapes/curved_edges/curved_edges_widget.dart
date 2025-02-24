import 'package:flutter/material.dart';
import 'package:fstoreapp/common/widgets/custom_shapes/curved_edges/curved_edges.dart';

class FCurvedEdgesWidget extends StatelessWidget {
  const FCurvedEdgesWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: FCustomCurvedEdges(), child: child);
  }
}
