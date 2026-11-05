import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/textconstants.dart';

class Profilecontainer extends StatelessWidget {
  const Profilecontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.profileCardBackground, borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundColor: AppColors.avatarPlaceholder),
          Text(
            Textconstants.displaynamePlaceholder,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            Textconstants.usernamePlaceholder,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
