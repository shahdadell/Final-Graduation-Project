import 'package:flutter/material.dart';
// import 'package:graduation_project/Theme/theme.dart';

class DialogUtils {
  static void showLoading(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).primaryColor,
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 12),
                Text(
                  message,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
    BuildContext context,
    String message, {
    String title = 'Alert',
    String? posActionName,
    VoidCallback? posAction,
    String? negActionName,
    VoidCallback? negAction,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: Theme.of(context).textTheme.titleLarge),
          content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
          actions: [
            if (negActionName != null)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (negAction != null) negAction();
                },
                child: Text(negActionName),
              ),
            if (posActionName != null)
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (posAction != null) posAction();
                },
                child: Text(posActionName),
              ),
          ],
        );
      },
    );
  }
}
