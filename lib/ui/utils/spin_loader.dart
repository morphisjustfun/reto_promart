import 'dart:async';

import 'package:flutter/material.dart';

Future<dynamic> withSpinLoader(BuildContext context, FutureOr<dynamic> Function() callback,
    bool mounted) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  final result = await callback();
  if (!mounted) return;
  Navigator.of(context).pop();
  return result;
}
