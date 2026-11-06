import 'package:flutter/material.dart';


class EyeButton extends StatelessWidget {
  final bool visible;
  final VoidCallback onPressed;
  final Color background;
  final Color iconColor;
  final Color? borderColor;

  const EyeButton({
    super.key,
    required this.visible,
    required this.onPressed,
    required this.background,
    required this.iconColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(8),
        ),
        side: borderColor != null
            ? BorderSide(color: borderColor!)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 42,
          height: 52,
          child: Icon(
            visible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            size: 32,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}