import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/widgets/rectangleiconbutton.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.sidebarBackground,
        border: BoxBorder.fromLTRB(
          right: BorderSide(color: AppColors.border, width: 2),
        ),
      ),
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
            buttonColor: AppColors.accentCyan,
            icon: Icon(Icons.home),
            onPressed: () {},
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
            buttonColor: AppColors.accentCyan,
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
          RectangleIconbutton(
            buttonColor: Colors.black,
            icon: Icon(Icons.email, color: Colors.white,),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
