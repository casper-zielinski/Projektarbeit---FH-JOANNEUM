import 'package:flutter/material.dart';
import 'package:flutterapp/widgets/footer.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 170, 211, 244),
              border: BoxBorder.fromLTRB(left: BorderSide(color: Colors.blue)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Footer(isAuthenitcated: false),
    );
  }
}
