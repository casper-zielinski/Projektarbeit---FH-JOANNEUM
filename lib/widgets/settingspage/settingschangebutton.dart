import 'package:flutter/material.dart';

class Settingschangebutton extends StatelessWidget {
  final bool change;
  final VoidCallback onPressed;

  const Settingschangebutton({
    super.key,
    required this.change,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: change ? Colors.green : Colors.black,
          foregroundColor: change ? Colors.green.shade900 : Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 28),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text("Change"),
      ),
    );
  }
}
