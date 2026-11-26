import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';

class Profileinfo extends StatelessWidget {
  final String displayName;
  final String userName;
  final bool? hideName;
  const Profileinfo({
    super.key,
    required this.displayName,
    required this.userName,
    this.hideName,
  });

  @override
  Widget build(BuildContext context) {
    bool hideInfo = hideName ?? false;
    return Row(
      spacing: 6,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.avatarPlaceholder,
          child: Text(
            displayName.substring(0, 1),
            style: TextStyle(color: AppColors.textPrimary),
          ),
        ),
        SizedBox(height: 4),
        ?!hideInfo
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    displayName,
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
