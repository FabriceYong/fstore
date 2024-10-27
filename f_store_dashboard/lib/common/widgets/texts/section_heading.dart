import 'package:flutter/material.dart';

class FSectionHeading extends StatelessWidget {
  const FSectionHeading(
      {super.key, required this.title, this.textColor, this.rightSideWidget});
  final String title;
  final Color? textColor;
  final Widget? rightSideWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: textColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (rightSideWidget != null) rightSideWidget!
      ],
    );
  }
}
