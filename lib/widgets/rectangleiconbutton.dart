import 'package:flutter/material.dart';

class RectangleIconbutton extends StatelessWidget {
  const RectangleIconbutton({
    super.key,
    required this.buttonColor,
    required this.icon,
    required this.onPressed,
    this.padding,
    this.constraints,
  });

  final void Function()? onPressed;
  final Widget icon;
  final Color buttonColor;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,

      padding: padding ?? EdgeInsets.symmetric(horizontal: 18),
      style: IconButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      constraints: constraints,
    );
  }
}
