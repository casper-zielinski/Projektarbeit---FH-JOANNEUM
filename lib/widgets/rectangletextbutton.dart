import 'package:flutter/material.dart';

class RectangleTextbutton extends StatelessWidget {
  const RectangleTextbutton({
    super.key,
    required this.buttonColor,
    required this.child,
    required this.onPressed,
  });

  final Color buttonColor;
  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: child,
    );
  }
}
