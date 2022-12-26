import 'dart:async';

import 'package:flutter/material.dart';

Future<dynamic> withConfirmationDialog(BuildContext context, String title, String message,
    FutureOr<dynamic> Function() callback, bool mounted) async {
  final result = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Sí'),
          ),
        ],
      );
    },
  );
  if (!mounted) return;
  if (result == true) {
    return (await callback());
  }
}