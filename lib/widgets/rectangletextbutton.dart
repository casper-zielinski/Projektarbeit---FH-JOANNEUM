import 'package:flutter/material.dart';

class RectangleTextbutton extends StatelessWidget {
  const RectangleTextbutton({
    super.key,
    required this.buttonColor,
    required this.child,
    required this.onPressed,
    this.size,
  });

  final Color buttonColor;
  final Widget child;
  final void Function()? onPressed;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        minimumSize: size,
      ),
      child: child,
    );
  }
}
