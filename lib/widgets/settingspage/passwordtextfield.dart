import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/settingspage/eyebutton.dart';
import 'package:flutterapp/widgets/settingspage/settingschangebutton.dart';
import 'package:flutterapp/widgets/settingspage/settingstextfield.dart';

class Passwordtextfield extends StatefulWidget {
  const Passwordtextfield({super.key});

  @override
  State<Passwordtextfield> createState() => _PasswordtextfieldState();
}

class _PasswordtextfieldState extends State<Passwordtextfield> {
  late final TextEditingController _passwordController;
  bool _change = false;
  bool _visible = false;

  void _changeText() {
    setState(() {
      _change = !_change;
      _visible = true;
    });
  }

  void _changeVisibility() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 0,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Settingstextfield(
                label: "Your Password",
                controller: _passwordController,
                enabled: _change,
                obscureText: !_visible,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
              ),
            ),
            EyeButton(
              visible: _visible,
              onPressed: _changeVisibility,
              background: _visible ? Colors.green : Colors.red,
              iconColor: _visible ? Colors.green.shade900 : Colors.red.shade900,
            ),
          ],
        ),

        Settingschangebutton(change: _change, onPressed: _changeText),
      ],
    );
  }
}
