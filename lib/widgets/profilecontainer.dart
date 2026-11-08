import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/textconstants.dart';

class Profilecontainer extends StatelessWidget {
  final User? user;
  const Profilecontainer({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.profileCardBackground,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(backgroundColor: AppColors.avatarPlaceholder, child: Text(user?.displayName?.substring(0,1) ?? '', style: TextStyle(
            color: AppColors.textPrimary
          ),),),
          SizedBox(height: 4),
          Text(
            user?.displayName ?? Textconstants.displaynamePlaceholder,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            user?.displayName ?? Textconstants.displaynamePlaceholder,
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
