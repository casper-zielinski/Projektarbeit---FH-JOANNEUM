import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';

class Settingscontainer extends StatelessWidget {
  const Settingscontainer({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });
  final Icon icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 12,
            children: [
              icon,
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          child,
        ],
      ),
    );
  }
}
