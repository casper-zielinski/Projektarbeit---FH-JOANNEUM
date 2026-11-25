import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appcolors.dart';
import 'package:flutterapp/widgets/postfeed/profileinfo.dart';
import 'package:flutterapp/widgets/rectangleiconbutton.dart';

class Poster extends StatefulWidget {
  final User? user;
  const Poster({super.key, required this.user});

  @override
  State<Poster> createState() => _PosterState();
}

class _PosterState extends State<Poster> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        spacing: 24,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Profileinfo(user: widget.user, hideName: true),
              TextField(
                controller: _textController,
                minLines: 1,
                maxLines: 8,
                cursorColor: AppColors.info,
                decoration: InputDecoration(
                  hintText: "Whats happening...",
                  constraints: BoxConstraints(maxWidth: 200),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Icon(Icons.image),
              Icon(Icons.gif),
              Icon(Icons.emoji_emotions),
              Icon(Icons.location_on),
              Expanded(
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _textController,
                  builder: (context, value, child) {
                    return RectangleIconbutton(
                      buttonColor: value.text.isNotEmpty
                          ? AppColors.info
                          : AppColors.secondary,
                      icon: Icon(Icons.email, size: 20),
                      onPressed: () {},
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 10,
                      ),
                      constraints: const BoxConstraints(),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
