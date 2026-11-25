import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/textconstants.dart';

class Profileinfo extends StatelessWidget {
  final User? user;
  final bool? hideName;
  const Profileinfo({super.key, required this.user, this.hideName});

  @override
  Widget build(BuildContext context) {
    bool hideInfo = hideName ?? false;
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.avatarPlaceholder,
          child: Text(
            user?.displayName?.substring(0, 1) ?? '',
            style: TextStyle(color: AppColors.textPrimary),
          ),
        ),
        SizedBox(height: 4),
        ?!hideInfo
            ? Column(
                children: [
                  Text(
                    user?.displayName ?? Textconstants.displaynamePlaceholder,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    user?.displayName ?? Textconstants.usernamePlaceholder,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            : null,
      ],
    );
  }
}
