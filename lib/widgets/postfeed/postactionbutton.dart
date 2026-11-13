import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';

/// Kompakter Icon-Button für die Aktionsleiste eines Posts (Like, Repost, ...).
class PostActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const PostActionButton({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () {},
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      visualDensity: VisualDensity.compact,
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStatePropertyAll(Size(28, 28)),
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
      ),
      icon: Icon(icon, color: AppColors.iconDefault, size: 16),
    );
  }
}
