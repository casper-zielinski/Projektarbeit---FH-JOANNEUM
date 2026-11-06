import 'package:flutter/material.dart';

class Settingstextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int? minLines;
  final bool? enabled;
  final bool? obscureText;
  final BorderRadius? borderRadius;

  const Settingstextfield({
    super.key,
    required this.label,
    required this.controller,
    this.minLines,
    this.enabled,
    this.obscureText,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    bool editable = enabled ?? true;
    bool hidden = obscureText ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          enabled: editable,
          minLines: minLines,
          maxLines: minLines ?? 1,
          obscureText: hidden,
          controller: controller,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
          ),
        ),
      ],
    );
  }
}
