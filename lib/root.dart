import 'package:flutter/material.dart';
import 'package:flutterapp/constants/apppage.dart';
import 'package:flutterapp/pages/home.dart';
import 'package:flutterapp/pages/settings.dart';
import 'package:flutterapp/service/authservice.dart';
import 'package:flutterapp/widgets/footer/footer.dart';
import 'package:flutterapp/widgets/sidebar.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  AppPage _page = AppPage.home;

  void _goTo(AppPage page) => setState(() => _page = page);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userChanges,
      builder: (context, snapshot) {
        final user = snapshot.data;
        return Scaffold(
          body: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Sidebar(onSelect: (apppage) => _goTo(apppage)),
              Expanded(
                child: switch (_page) {
                  AppPage.home => const Home(),
                  AppPage.settings => Settings(user: user),
                },
              ),
            ],
          ),
          bottomNavigationBar: Footer(user: user),
        );
      },
    );
  }
}
