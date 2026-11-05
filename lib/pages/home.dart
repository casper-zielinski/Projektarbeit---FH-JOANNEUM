import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appkeys.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(key: Appkeys.homePage);
  }
}
