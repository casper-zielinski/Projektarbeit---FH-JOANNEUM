import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/service/Exceptions/authexception.dart';

class Toastservice {
  Future<void> useToastWithUserInfo(
    BuildContext context,
    String successmessage,
    String defaultErrorMessage,
    Future<User?> Function() function, {
    bool? dontCloseContext,
  }) async {
    try {
      User? user = await function();
      if (context.mounted) {
        if (dontCloseContext == null) Navigator.pop(context);
        _showToast(context, "$successmessage ${user?.displayName ?? "User"}");
      }
    } on AuthException catch (error) {
      if (context.mounted) _showToast(context, error.message);
    } catch (error) {
      if (context.mounted) _showToast(context, defaultErrorMessage);
    }
  }

  Future<void> useToast(
    BuildContext context,
    String successmessage,
    String defaultErrorMessage,
    Future<void> Function() function,
  ) async {
    try {
      await function();
      if (context.mounted) _showToast(context, successmessage);
    } on AuthException catch (error) {
      if (context.mounted) _showToast(context, error.message);
    } catch (error) {
      if (context.mounted) _showToast(context, defaultErrorMessage);
    }
  }

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
