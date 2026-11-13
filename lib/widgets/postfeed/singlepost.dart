import 'package:flutter/material.dart';
import 'package:flutterapp/constants/AppKeys.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/widgets/postfeed/postactionbutton.dart';

class Singlepost extends StatelessWidget {
  const Singlepost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 2, color: AppColors.border)),
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Placeholder Post Text",
                style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "4 days ago",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("3"),
                  PostActionButton(icon: Icons.thumb_up),
                ],
              ),
              PostActionButton(icon: Icons.repeat),
              PostActionButton(
                icon: Icons.chat_bubble,
                key: Appkeys.commentButton,
              ),
              PostActionButton(icon: Icons.visibility),
              PostActionButton(icon: Icons.bookmark_add),
              PostActionButton(icon: Icons.save_alt),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Show Comments",
                  style: TextStyle(fontSize: 12, color: AppColors.textPrimary),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_drop_down_circle_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
