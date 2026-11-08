import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/textconstants.dart';
import 'package:flutterapp/service/Exceptions/authexception.dart';
import 'package:flutterapp/service/authservice.dart';
import 'package:flutterapp/widgets/rectangletextbutton.dart';
import 'package:flutterapp/widgets/settingspage/settingscontainer.dart';
import 'package:flutterapp/widgets/settingspage/settingstextfield.dart';

class Profilesection extends StatefulWidget {
  final User? user;
  const Profilesection({super.key, required this.user});

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
      text: widget.user?.displayName ?? Textconstants.usernamePlaceholder,
    );
    _displayNameController = TextEditingController(
      text: widget.user?.displayName ?? Textconstants.usernamePlaceholder,
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
  void didUpdateWidget(covariant Profilesection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user != widget.user) {
      _usernameController.text =
          widget.user?.displayName ?? Textconstants.usernamePlaceholder;
      _displayNameController.text =
          widget.user?.displayName ?? Textconstants.usernamePlaceholder;
    }
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
            onPressed: () async {
              try {
                await AuthService().signOut();
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Successfully loged out!")),
                  );
                }
              } on AuthException catch (error) {
                if (context.mounted) {
                  String message = error.message;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));
                }
              } catch (error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Logout failed for an unknown reason, please try again.",
                      ),
                    ),
                  );
                }
              }
            },
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
