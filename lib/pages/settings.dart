import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Appkeys.settingsPage,
      padding: EdgeInsets.only(top: 32, bottom: 6, left: 6, right: 6),
      color: AppColors.background,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Settings",
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
