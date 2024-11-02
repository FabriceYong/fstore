import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class FCartCounterIcon extends StatelessWidget {
  const FCartCounterIcon({
    super.key,
    this.iconColor,
    required this.onPressed,
  });

  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Iconsax.shopping_bag,
            color: iconColor,
          ),
        ),
        Positioned(
          right: 7,
          top: 7,
          child: Container(
            width: 17,
            height: 17,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '0',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: FColors.white, fontSizeFactor: .9),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
