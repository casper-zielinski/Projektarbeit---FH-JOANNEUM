import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/service/Exceptions/authexception.dart';

class Toastservice {
  Future<void> useToastWithUserInfo(
    BuildContext context,
    String successmessage,
    String defaultErrorMessage,
    Future<User?> Function() function,
  ) async {
    try {
      User? user = await function();
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$successmessage ${user?.displayName ?? "User"}"),
          ),
        );
      }
    } on AuthException catch (error) {
      if (context.mounted) {
        String message = error.message;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(defaultErrorMessage)));
      }
    }
  }
}
