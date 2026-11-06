import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/widgets/settingspage/settingscontainer.dart';

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Settingscontainer(
      icon: Icon(Icons.color_lens, color: Colors.red, size: 32),
      title: "Appearance",
      child: Column(
        mainAxisSize: MainAxisSize.max,
        spacing: 16,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Switch Themes",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 186,
                    child: Text(
                      "Click the Button to switch Themes",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.wb_sunny_outlined),
                color: AppColors.iconDefault,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
