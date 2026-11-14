import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/constants/appkeys.dart';

Future<void> pumpUntil(
  WidgetTester tester,
  bool Function() condition, {
  Duration timeout = const Duration(seconds: 15),
  String reason = 'condition',
}) async {
  final end = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(end)) {
      fail('Timed out after $timeout waiting for $reason');
    }
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.pumpAndSettle();
}

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
  await tester.pump(); // rebuild so the submit button becomes enabled
  await tester.tap(find.byKey(Appkeys.signUpButton));
  await pumpUntil(
    tester,
    () => find.byKey(Appkeys.unauthenticatedFooter).evaluate().isEmpty,
    reason: 'sign up to finish (footer to become authenticated)',
  );
}

Future<void> fillAndSubmitLogin(
  WidgetTester tester, {
  required String email,
  required String password,
}) async {
  expect(find.byKey(Appkeys.loginModal), findsOneWidget);
  await tester.enterText(find.byKey(Appkeys.emailTextField), email);
  await tester.enterText(find.byKey(Appkeys.passwordTextField), password);
  await tester.pump(); // rebuild so the submit button becomes enabled
  await tester.tap(find.byKey(Appkeys.logInButton));
  await pumpUntil(
    tester,
    () => find.byKey(Appkeys.unauthenticatedFooter).evaluate().isEmpty,
    reason: 'login to finish (footer to become authenticated)',
  );
}

Future<void> logOut(WidgetTester tester) async {
  await tester.tap(find.byKey(Appkeys.settingsButton));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Appkeys.logoutButton));
  await pumpUntil(
    tester,
    () => find.byKey(Appkeys.unauthenticatedFooter).evaluate().isNotEmpty,
    reason: 'logout to finish (unauthenticated footer)',
  );
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

String settingsFieldText(WidgetTester tester, Key key) {
  return tester
      .widget<EditableText>(
        find.descendant(of: find.byKey(key), matching: find.byType(EditableText)),
      )
      .controller
      .text;
}
