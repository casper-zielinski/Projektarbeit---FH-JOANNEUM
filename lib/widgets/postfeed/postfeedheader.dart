import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/constants/postfeedpage.dart';

class Postfeedheader extends StatelessWidget {
  final Postfeedpage page;
  final void Function(Postfeedpage) onSelect;

  const Postfeedheader({super.key, required this.page, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 32, bottom: 0, left: 6, right: 6),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 12,
        children: [
          Column(
            children: [
              TextButton(
                onPressed: () {
                  onSelect(Postfeedpage.forYou);
                },
                child: Text(
                  "For You",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: page == Postfeedpage.forYou
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              if (page == Postfeedpage.forYou)
                Container(
                  constraints: BoxConstraints(maxHeight: 3, minWidth: 68),
                  decoration: BoxDecoration(color: AppColors.accentCyan),
                ),
            ],
          ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  onSelect(Postfeedpage.following);
                },
                child: Text(
                  "Following",
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: page == Postfeedpage.following
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              if (page == Postfeedpage.following)
                Container(
                  constraints: BoxConstraints(maxHeight: 3, minWidth: 68),
                  decoration: BoxDecoration(color: AppColors.accentCyan),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
