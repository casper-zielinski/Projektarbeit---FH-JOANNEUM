import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/constants/AppKeys.dart';


Future<void> fillAndSubmitSignUp(
  WidgetTester tester, {
  required String username,
  required String email,
  required String password,
}) async {
  expect(find.byKey(Appkeys.signUpModal), findsOneWidget);
  await tester.enterText(find.byKey(Appkeys.usernameTextField), username);
  await tester.enterText(find.byKey(Appkeys.emailTextField), email);
  await tester.enterText(find.byKey(Appkeys.passwordTextField), password);
  await tester.tap(find.byKey(Appkeys.signUpButton));
  await tester.pumpAndSettle();
}

Future<void> fillAndSubmitLogin(
  WidgetTester tester, {
  required String email,
  required String password,
}) async {
  expect(find.byKey(Appkeys.loginModal), findsOneWidget);
  await tester.enterText(find.byKey(Appkeys.emailTextField), email);
  await tester.enterText(find.byKey(Appkeys.passwordTextField), password);
  await tester.tap(find.byKey(Appkeys.logInButton));
  await tester.pumpAndSettle();
}

Future<void> logOut(WidgetTester tester) async {
  await tester.tap(find.byKey(Appkeys.settingsButton));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Appkeys.logoutButton));
  await tester.pumpAndSettle();
  expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);
}

bool isObscured(WidgetTester tester) {
  return tester
      .widget<EditableText>(
        find.descendant(
          of: find.byKey(Appkeys.passwordTextField),
          matching: find.byType(EditableText),
        ),
      )
      .obscureText;
}
