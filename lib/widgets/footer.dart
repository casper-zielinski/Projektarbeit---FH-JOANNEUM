import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key, required this.isAuthenitcated});

  final bool isAuthenitcated;

  @override
  Widget build(BuildContext context) {
    return isAuthenitcated
        ? Container()
        : Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(color: Colors.blue, border: BoxBorder.fromLTRB(top: BorderSide(
              width: 2, color: Colors.lightBlue.shade400
            ))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                Text(
                  "Don't miss out on chatting with your Brain",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 165, 227, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "People on ChatAI are the first to know",
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(250, 0, 0, 0),
                      ),
                      child: Text(
                        "Log In",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          249,
                          24,
                          175,
                          195,
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 30, 62, 80),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          248,
                          24,
                          195,
                          141,
                        ),
                      ),
                      child: Text(
                        "Login as Guest",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 25, 69, 52),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
