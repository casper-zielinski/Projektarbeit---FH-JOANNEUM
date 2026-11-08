import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';

class Authenticatedfooter extends StatelessWidget {
  const Authenticatedfooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: BoxBorder.fromLTRB(
          top: BorderSide(width: 2, color: AppColors.border),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,

      ),
    );
  }
}
