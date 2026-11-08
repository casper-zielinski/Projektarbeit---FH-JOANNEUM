import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';

class Authenticatedfooter extends StatelessWidget {
  const Authenticatedfooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: BoxBorder.fromLTRB(
          top: BorderSide(width: 2, color: AppColors.border),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.post_add),
            padding: EdgeInsets.all(6),
            color: AppColors.iconDefault,
            style: IconButton.styleFrom(backgroundColor: AppColors.info),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home),
                  padding: EdgeInsets.all(6),
                  color: AppColors.info,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  padding: EdgeInsets.all(6),
                  color: AppColors.info,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.chat_bubble),
                  padding: EdgeInsets.all(6),
                  color: AppColors.info,
                ),
                SizedBox(width: 32,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
