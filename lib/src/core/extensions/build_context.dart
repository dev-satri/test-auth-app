import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  showSnackbar(String text, {bool isError = false}) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(text),
          backgroundColor: isError ? Colors.red : Colors.green,
        ),
      );
}
