import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/widgets/rectangletextbutton.dart';

class Unauthicatedfooter extends StatelessWidget {
  const Unauthicatedfooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Appkeys.unauthenticatedFooter,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.banner,
        border: BoxBorder.fromLTRB(
          top: BorderSide(width: 2, color: AppColors.border),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Text(
            "Don't miss out on chatting with your Brain",
            style: TextStyle(
              color: AppColors.bannerTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "People on ChatAI are the first to know",
            style: TextStyle(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              RectangleTextbutton(
                buttonColor: const Color.fromARGB(250, 0, 0, 0),
                child: Text("Log In", style: TextStyle(color: Colors.blue)),
                onPressed: () {},
              ),
              RectangleTextbutton(
                buttonColor: AppColors.accentCyan,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 30, 62, 80),
                  ),
                ),
                onPressed: () {},
              ),
              RectangleTextbutton(
                buttonColor: AppColors.guestTeal,
                child: Text(
                  "Login as Guest",
                  style: TextStyle(color: AppColors.textOnAccent),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
