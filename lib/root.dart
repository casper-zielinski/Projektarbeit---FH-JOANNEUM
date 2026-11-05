import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/footer.dart';
import 'package:flutterapp/widgets/sidebar.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(mainAxisSize: MainAxisSize.max, children: [Sidebar()]),
      bottomNavigationBar: Footer(isAuthenitcated: false),
    );
  }
}
