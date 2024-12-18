import 'package:flutter/material.dart';

class FPageHeading extends StatelessWidget {
  const FPageHeading({super.key, required this.heading, this.rightSideWidget});

  final String heading;
  final Widget? rightSideWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(heading, style: Theme.of(context).textTheme.headlineLarge,),
        rightSideWidget ?? SizedBox()
      ],
    );
  }
}