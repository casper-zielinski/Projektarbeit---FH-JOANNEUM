import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/apppage.dart';
import 'package:flutterapp/widgets/profilecontainer.dart';
import 'package:flutterapp/widgets/rectangleiconbutton.dart';

class Sidebar extends StatelessWidget {
  final void Function(AppPage) onSelect;
  final User? user;

  const Sidebar({super.key, required this.onSelect, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 32, bottom: 6, left: 6, right: 6),
      decoration: BoxDecoration(
        color: AppColors.sidebarBackground,
        border: BoxBorder.fromLTRB(
          right: BorderSide(color: AppColors.border, width: 2),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 46,
              height: 46,
              fit: BoxFit.cover,
            ),
            RectangleIconbutton(
              key: Appkeys.homebutton,
              buttonColor: AppColors.accentCyan,
              icon: Icon(Icons.home),
              onPressed: () {
                onSelect(AppPage.home);
              },
            ),
            RectangleIconbutton(
              buttonColor: AppColors.accentCyan,
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            RectangleIconbutton(
              buttonColor: AppColors.accentCyan,
              icon: Icon(Icons.notifications_active),
              onPressed: () {},
            ),
            RectangleIconbutton(
              buttonColor: AppColors.accentCyan,
              icon: Icon(Icons.message),
              onPressed: () {},
            ),
            RectangleIconbutton(
              buttonColor: AppColors.accentCyan,
              icon: Icon(Icons.deblur),
              onPressed: () {},
            ),
            RectangleIconbutton(
              key: Appkeys.settingsButton,
              buttonColor: AppColors.accentCyan,
              icon: Icon(Icons.settings),
              onPressed: () {
                onSelect(AppPage.settings);
              },
            ),
            RectangleIconbutton(
              buttonColor: Colors.black,
              icon: Icon(Icons.email, color: Colors.white),
              onPressed: () {},
            ),
            Profilecontainer(user: user),
          ],
        ),
      ),
    );
  }
}
