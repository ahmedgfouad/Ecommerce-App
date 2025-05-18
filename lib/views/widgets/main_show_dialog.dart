import 'package:flutter/material.dart';

Future<dynamic> mainShowdialog({
  required Object e,
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Error !", style: Theme.of(context).textTheme.bodyLarge),
          content: Text(
            e.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
            ),
          ],
        ),
  );
}
