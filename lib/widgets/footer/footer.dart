import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/footer/unauthicatedfooter.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.isAuthenitcated});

  final bool isAuthenitcated;

  @override
  Widget build(BuildContext context) {
    return isAuthenitcated
        ? Container()
        : Unauthicatedfooter();
  }
}
