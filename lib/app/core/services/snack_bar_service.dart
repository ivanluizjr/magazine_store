import 'package:flutter/material.dart';
import 'package:magazine_store/app/core/themes/app_colors.dart';
import 'package:magazine_store/app/core/widgets/text_widget.dart';

class SnackBarService {
  static void showError({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.redAccent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: message,
            textAlign: TextAlign.center,
          )
        ],
      ),
    ));
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.greenAccent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }

  static void showNotice({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.orange,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextWidget(
            text: message,
            textAlign: TextAlign.center,
            colorText: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    ));
  }
}
