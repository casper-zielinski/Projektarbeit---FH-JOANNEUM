import 'package:flutter/material.dart';

class RectangleTextbutton extends StatelessWidget {
  const RectangleTextbutton({
    super.key,
    required this.buttonColor,
    required this.child,
    required this.onPressed,
    this.size,
    this.borderColor,
  });

  final Color buttonColor;
  final Widget child;
  final void Function()? onPressed;
  final Size? size;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        minimumSize: size,
      ),
      child: child,
    );
  }
}
