import 'package:flutter/material.dart';
import 'package:fstoreapp/utils/constants/colors.dart';

class FSettingsMenuTile extends StatelessWidget {
  const FSettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      this.subTitle,
      this.trailing,
      this.onTap});
  final IconData icon;
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: FColors.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: subTitle != null
          ? Text(
              subTitle!,
              style: Theme.of(context).textTheme.labelMedium,
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
