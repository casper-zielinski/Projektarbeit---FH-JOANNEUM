import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/service/authservice.dart';
import 'package:flutterapp/service/dto/authorized.dart';
import 'package:flutterapp/service/dto/post.dart';
import 'package:flutterapp/service/firestoreservice.dart';
import 'package:flutterapp/widgets/modal/commentmodal.dart';
import 'package:flutterapp/widgets/modal/guestrestrictionmodal.dart';
import 'package:flutterapp/widgets/modal/restrictionmodal.dart';
import 'package:flutterapp/widgets/postfeed/postactionbutton.dart';
import 'package:flutterapp/widgets/postfeed/profileinfo.dart';
import 'package:timeago/timeago.dart' as timeago;

class Singlepost extends StatelessWidget {
  final Post post;
  final bool showBorder;
  const Singlepost({super.key, required this.post, required this.showBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: showBorder
            ? Border(bottom: BorderSide(width: 2, color: AppColors.border))
            : null,
      ),
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Profileinfo(displayName: post.name, userName: post.username),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  post.text,
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 18),
                  softWrap: true,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                timeago.format(post.timeStamp),
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
                  Text(post.likes.length.toString()),
                  PostActionButton(
                    icon: Icons.thumb_up,
                    key: Appkeys.likeButton,
                    color:
                        post.likes.contains(
                          FirebaseAuth.instance.currentUser?.email,
                        )
                        ? AppColors.primaryBlue
                        : null,
                    onPressed: () async {
                      if (Authorized.isGuest) {
                        showDialog(
                          context: context,
                          barrierColor: AppColors.modalBarrier,
                          builder: (context) => const Guestrestrictionmodal(),
                        );
                      } else if (!Authorized.isAuthenticated) {
                        showDialog(
                          context: context,
                          barrierColor: AppColors.modalBarrier,
                          builder: (context) => const Guestrestrictionmodal(),
                        );
                      } else {
                        await Firestoreservice().likePost(
                          post.id ?? "",
                          FirebaseAuth.instance.currentUser?.email ?? "",
                        );
                      }
                    },
                  ),
                ],
              ),
              PostActionButton(icon: Icons.repeat),
              PostActionButton(
                icon: Icons.chat_bubble,
                key: Appkeys.commentButton,
                onPressed: () async {
                  if (Authorized.isGuest) {
                    showDialog(
                      context: context,
                      barrierColor: AppColors.modalBarrier,
                      builder: (context) => const Guestrestrictionmodal(),
                    );
                  } else if (!Authorized.isAuthenticated) {
                    showDialog(
                      context: context,
                      barrierColor: AppColors.modalBarrier,
                      builder: (context) => const Restrictionmodal(),
                    );
                  } else {
                    showDialog(
                      context: context,
                      barrierColor: AppColors.modalBarrier,
                      builder: (context) => const Commentmodal(),
                    );
                  }
                },
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
