import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/widgets/settingspage/accountandsecuritysection.dart';
import 'package:flutterapp/widgets/settingspage/appearancesection.dart';
import 'package:flutterapp/widgets/settingspage/profilesection.dart';

class Settings extends StatelessWidget {
  final User? user;

  const Settings({super.key, required this.user});

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
          spacing: 12,
          children: [
            Text(
              "Settings",
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Manage your account settings and preferences",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Profilesection(user: user),
            Accountandsecuritysection(user: user),
            AppearanceSection(),
          ],
        ),
      ),
    );
  }
}
