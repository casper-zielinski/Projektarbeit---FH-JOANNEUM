import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';

/// Placeholder comment dialog shown to authenticated (non-guest) users.
class Commentmodal extends StatelessWidget {
  const Commentmodal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: Appkeys.commentModal,
      backgroundColor: AppColors.modalBackground,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              const Text(
                'Comment',
                style: TextStyle(
                  color: AppColors.modalTitle,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.modalTitle),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
