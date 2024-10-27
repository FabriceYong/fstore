
import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';
import 'package:fstoreapp/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class FProfileMenu extends StatelessWidget {
  const FProfileMenu(
      {super.key,
      required this.onPressed,
      this.icon = Iconsax.arrow_right,
      required this.title,
      required this.value});

  final IconData icon;
  final void Function() onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(FSizes.spaceBtwItems / 2),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
              child: Icon(
                icon,
                color: FColors.primary,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
