import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/settingspage/emailtextfield.dart';
import 'package:flutterapp/widgets/settingspage/passwordtextfield.dart';
import 'package:flutterapp/widgets/settingspage/settingscontainer.dart';

class Accountandsecuritysection extends StatelessWidget {
  const Accountandsecuritysection({super.key});

  @override
  Widget build(BuildContext context) {
    return Settingscontainer(
      icon: Icon(Icons.security, color: Colors.green, size: 32),
      title: "Account & Security",
      child: Column(
        mainAxisSize: MainAxisSize.max,
        spacing: 16,
        children: [Emailtextfield(), Passwordtextfield()],
      ),
    );
  }
}
