import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/widgets/settingspage/eyebutton.dart';

class ModalTextFieldPassword extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const ModalTextFieldPassword({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.onChanged,
  });

  @override
  State<ModalTextFieldPassword> createState() => _ModalTextFieldPasswordState();
}

class _ModalTextFieldPasswordState extends State<ModalTextFieldPassword> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.modalLabel),
            ),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: _obscured,
                  autocorrect: false,
                  enableSuggestions: false,
                  onChanged: widget.onChanged,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.modalText,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
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
              ),
              EyeButton(
                key: Appkeys.togglePasswordVisibilityButton,
                visible: _obscured,
                onPressed: () => setState(() => _obscured = !_obscured),
                background: AppColors.modalBackground,
                iconColor: AppColors.info,
                borderColor: AppColors.info,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
