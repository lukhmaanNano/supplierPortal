import 'package:flutter/material.dart';
import '../styles/common Color.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> toaster(
    context, String message) {
  return ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
      backgroundColor: red,
      duration: const Duration(seconds: 1, milliseconds: 1000),
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.white),
          const SizedBox(
            width: 12,
          ),
          Text(
            message,
            style: const TextStyle(
                letterSpacing: 1, fontSize: 12, color: Colors.white),
          ),
        ],
      )));
}
