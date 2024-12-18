import 'package:f_store_dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FDialogs {
  static defaultDialog({
    required BuildContext context,
    String title = 'Removal Confirmation',
    String content =
        'Removing this message will delete all related data. Are you sure?',
    String positive = 'Confirm',
    String negative = 'Cancel',
    Function()? onPositive,
    Function()? onNegative,
  })
  // Show Confirmation dialog box
  {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(FSizes.md),
                  ),
                ),
                onPressed: onNegative ?? () => Navigator.of(context).pop(),
                child: Text(negative),
              ),
              TextButton(onPressed: onPositive, child: Text(positive))
            ],
          );
        });
  }
}
