import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/textconstants.dart';
import 'package:flutterapp/widgets/rectangletextbutton.dart';
import 'package:flutterapp/widgets/settingspage/settingscontainer.dart';
import 'package:flutterapp/widgets/settingspage/settingstextfield.dart';

class Profilesection extends StatefulWidget {
  const Profilesection({super.key});

  @override
  State<Profilesection> createState() => _ProfilesectionState();
}

class _ProfilesectionState extends State<Profilesection> {
  late final TextEditingController _usernameController;
  late final TextEditingController _displayNameController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: Textconstants.usernamePlaceholder,
    );
    _displayNameController = TextEditingController(
      text: Textconstants.displaynamePlaceholder,
    );
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Settingscontainer(
      icon: Icon(Icons.person_pin, color: Colors.blueAccent, size: 32),
      title: "Profile",
      child: Column(
        mainAxisSize: MainAxisSize.max,
        spacing: 12,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 6,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.avatarPlaceholder,
                child: Icon(Icons.camera_enhance_rounded, size: 24),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Picture",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Upload a Profile Picture",
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
          Settingstextfield(label: "Username", controller: _usernameController),
          Settingstextfield(
            key: Appkeys.displayName,
            label: "Display Name",
            controller: _displayNameController,
          ),
          Settingstextfield(
            label: "Bio",
            controller: _bioController,
            minLines: 4,
          ),
          RectangleTextbutton(
            key: Appkeys.logoutButton,
            buttonColor: Colors.grey,
            onPressed: () {},
            size: Size(240, 36),
            child: Text(
              "Log out",
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
