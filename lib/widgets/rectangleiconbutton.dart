import 'package:flutter/material.dart';

class RectangleIconbutton extends StatelessWidget {
  const RectangleIconbutton({
    super.key,
    required this.buttonColor,
    required this.icon,
    required this.onPressed,
  });

  final void Function()? onPressed;
  final Widget icon;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      padding: EdgeInsets.symmetric(horizontal: 18),
      style: IconButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
