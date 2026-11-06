import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/textconstants.dart';
import 'package:flutterapp/widgets/settingscontainer.dart';

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
          spacing: 10,
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
            Settingscontainer(
              icon: Icon(Icons.person_pin, color: Colors.blueAccent, size: 32),
              title: "Profile",
              child: Column(
                mainAxisSize: MainAxisSize.max,
                spacing: 8,
                children: [
                  TextField(
                    controller: TextEditingController(
                      text: Textconstants.usernamePlaceholder,
                    ),
                  ),
                  TextField(
                    controller: TextEditingController(
                      text: Textconstants.displaynamePlaceholder,
                    ),
                  ),
                ],
              ),
            ),
            Settingscontainer(
              icon: Icon(Icons.security, color: Colors.green, size: 32),
              title: "Account & Security",
              child: Column(
                mainAxisSize: MainAxisSize.max,
                spacing: 8,
                children: [
                  TextField(
                    controller: TextEditingController(
                      text: Textconstants.emailPlaceholder,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
