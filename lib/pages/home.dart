import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/postfeedpage.dart';
import 'package:flutterapp/service/dto/post.dart';
import 'package:flutterapp/service/firestoreservice.dart';
import 'package:flutterapp/widgets/postfeed/poster.dart';
import 'package:flutterapp/widgets/postfeed/postfeedheader.dart';
import 'package:flutterapp/widgets/postfeed/singlepost.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Postfeedpage _page = Postfeedpage.forYou;
  late final Stream<List<Post>> _postsStream;

  @override
  void initState() {
    super.initState();
    _postsStream = Firestoreservice().getPostsStream();
  }

  void _goTo(Postfeedpage page) => setState(() => _page = page);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Appkeys.homePage,
      children: [
        Postfeedheader(page: _page, onSelect: (page) => _goTo(page)),
        Poster(user: widget.user),
        Expanded(
          child: StreamBuilder<List<Post>>(
            stream: _postsStream,
            builder: (context, snapshot) {
              final posts = snapshot.data ?? [];

              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final isLast = index == posts.length - 1;
                  final post = posts[index];
                  return Singlepost(
                    post: post,
                    showBorder: !isLast,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
