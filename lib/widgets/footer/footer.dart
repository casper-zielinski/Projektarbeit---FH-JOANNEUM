import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/footer/authenticatedfooter.dart';
import 'package:flutterapp/widgets/footer/unauthicatedfooter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return user != null ? Authenticatedfooter() : Unauthicatedfooter();
  }
}
