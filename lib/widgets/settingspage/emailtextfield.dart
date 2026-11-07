import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/textconstants.dart';
import 'package:flutterapp/widgets/settingspage/settingschangebutton.dart';
import 'package:flutterapp/widgets/settingspage/settingstextfield.dart';

class Emailtextfield extends StatefulWidget {
  final String email;
  const Emailtextfield({super.key, required this.email});

  @override
  State<Emailtextfield> createState() => _EmailtextfieldState();
}

class _EmailtextfieldState extends State<Emailtextfield> {
  late final TextEditingController _emailController;
  bool _change = false;

  void _changeText() {
    setState(() {
      _change = !_change;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(
      text: widget.email,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Settingstextfield(
          key: Appkeys.email,
          label: "Your Email",
          controller: _emailController,
          enabled: _change,
        ),
        Settingschangebutton(change: _change, onPressed: _changeText),
      ],
    );
  }
}
