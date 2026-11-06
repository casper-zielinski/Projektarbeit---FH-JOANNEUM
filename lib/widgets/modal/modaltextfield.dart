import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';

/// Dunkles Textfeld für Modals (Login/Sign Up) mit Label darüber,
/// Placeholder (hintText) und blauem Rand bei Fokus.
class ModalTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const ModalTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.modalLabel),
            ),
          ),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 14, color: AppColors.modalText),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.modalHint),
            filled: true,
            fillColor: AppColors.modalBackground,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.modalBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.modalBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.info),
            ),
          ),
        ),
      ],
    );
  }
}
