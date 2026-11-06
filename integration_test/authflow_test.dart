import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/textconstants.dart';
import 'package:flutterapp/main.dart';
import 'package:integration_test/integration_test.dart';

import 'util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets(
      'Unauthenticated User enters the app and switches to settings page and back',
      (tester) async {
        // Load app widget.
        await tester.pumpWidget(const MyApp());
        expect(find.byKey(Appkeys.homePage), findsOneWidget);
        expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);
        await tester.tap(find.byKey(Appkeys.settingsButton));
        await tester.pumpAndSettle();

        final settingsPage = find.byKey(Appkeys.settingsPage);

        expect(settingsPage, findsOneWidget);
        expect(
          find.descendant(
            of: settingsPage,
            matching: find.text(Textconstants.usernamePlaceholder),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: settingsPage,
            matching: find.text(Textconstants.displaynamePlaceholder),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: settingsPage,
            matching: find.text(Textconstants.emailPlaceholder),
          ),
          findsOneWidget,
        );
        await tester.tap(find.byKey(Appkeys.homebutton));
        await tester.pumpAndSettle();
        expect(find.byKey(Appkeys.homePage), findsOneWidget);
        expect(find.byKey(Appkeys.settingsPage), findsNothing);
      },
    );

    testWidgets("Unauthenticated User Sign's Up and Logs out", (tester) async {
      final String username = "John";
      final String email =
          "john.${DateTime.now().millisecondsSinceEpoch}@example.com";
      final String password = "secret1!";

      await tester.pumpWidget(const MyApp());
      expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);

      await tester.tap(find.byKey(Appkeys.openSignUpModalButton));

      await fillAndSubmitSignUp(
        tester,
        username: username,
        email: email,
        password: password,
      );

      expect(find.byKey(Appkeys.unauthenticatedFooter), findsNothing);
      await tester.tap(find.byKey(Appkeys.settingsButton));
      await tester.pumpAndSettle();

      expect(find.byKey(Appkeys.settingsPage), findsOneWidget);
      expect(find.text(username), findsOneWidget);
      expect(find.text(email), findsOneWidget);

      final Text usernameTextWidget = tester.widget<Text>(
        find.byKey(Appkeys.displayName),
      );
      final Text emailTextWidget = tester.widget<Text>(
        find.byKey(Appkeys.email),
      );

      expect(usernameTextWidget.data, username);
      expect(emailTextWidget.data, email);

      await logOut(tester);
    });

    testWidgets('User signs up, logs out, logs in again and logs out', (
      tester,
    ) async {
      // Eindeutige Mail pro Testlauf, sonst schlägt der Sign-up beim zweiten
      // Durchlauf mit "email-already-in-use" fehl.
      final String username = 'Jane';
      final String email =
          'jane.${DateTime.now().millisecondsSinceEpoch}@example.com';
      final String password = 'secret1!';

      await tester.pumpWidget(const MyApp());
      expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);

      await tester.tap(find.byKey(Appkeys.openSignUpModalButton));
      await fillAndSubmitSignUp(
        tester,
        username: username,
        email: email,
        password: password,
      );

      expect(find.byKey(Appkeys.unauthenticatedFooter), findsNothing);

      await logOut(tester);

      await tester.tap(find.byKey(Appkeys.openLoginModalButton));
      await tester.pumpAndSettle();
      await fillAndSubmitLogin(tester, email: email, password: password);

      expect(find.byKey(Appkeys.loginModal), findsNothing);
      expect(find.byKey(Appkeys.unauthenticatedFooter), findsNothing);

      await tester.tap(find.byKey(Appkeys.settingsButton));
      await tester.pumpAndSettle();
      expect(find.byKey(Appkeys.settingsPage), findsOneWidget);
      expect(
        tester.widget<Text>(find.byKey(Appkeys.displayName)).data,
        username,
      );
      expect(tester.widget<Text>(find.byKey(Appkeys.email)).data, email);

      await logOut(tester);
    });

    testWidgets('Password visibility can be toggled in the login modal', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.byKey(Appkeys.openLoginModalButton));
      await tester.pumpAndSettle();
      expect(find.byKey(Appkeys.loginModal), findsOneWidget);

      await tester.enterText(find.byKey(Appkeys.passwordTextField), 'secret1!');
      await tester.pump();

      expect(isObscured(tester), isTrue);

      await tester.tap(find.byKey(Appkeys.togglePasswordVisibilityButton));
      await tester.pump();
      expect(isObscured(tester), isFalse);

      await tester.tap(find.byKey(Appkeys.togglePasswordVisibilityButton));
      await tester.pump();
      expect(isObscured(tester), isTrue);
    });

    testWidgets(
      'Comment button: unauthenticated users receive sign-up-or-login modal, '
      'authenticated users receive comment modal',
      (tester) async {
        final String username = 'Carl';
        final String email =
            'carl.${DateTime.now().millisecondsSinceEpoch}@example.com';
        final String password = 'secret1!';

        await tester.pumpWidget(const MyApp());
        expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);

        await tester.tap(find.byKey(Appkeys.commentButton).first);
        await tester.pumpAndSettle();
        expect(find.byKey(Appkeys.signUpOrLoginModal), findsOneWidget);
        expect(find.byKey(Appkeys.commentModal), findsNothing);

        await tester.tap(find.byKey(Appkeys.signUpModalButtonsignupOrlogin));
        await tester.pumpAndSettle();
        expect(find.byKey(Appkeys.signUpOrLoginModal), findsNothing);
        expect(find.byKey(Appkeys.signUpModal), findsOneWidget);

        await fillAndSubmitSignUp(
          tester,
          username: username,
          email: email,
          password: password,
        );
        expect(find.byKey(Appkeys.signUpModal), findsNothing);
        expect(find.byKey(Appkeys.unauthenticatedFooter), findsNothing);

        await tester.tap(find.byKey(Appkeys.commentButton).first);
        await tester.pumpAndSettle();
        expect(find.byKey(Appkeys.commentModal), findsOneWidget);
        expect(find.byKey(Appkeys.signUpOrLoginModal), findsNothing);

        Navigator.of(tester.element(find.byKey(Appkeys.commentModal))).pop();
        await tester.pumpAndSettle();
        expect(find.byKey(Appkeys.commentModal), findsNothing);

        await logOut(tester);
      },
    );
  });

  testWidgets('User switches between login and sign-up modal', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(Appkeys.openLoginModalButton));
    await tester.pumpAndSettle();
    expect(find.byKey(Appkeys.loginModal), findsOneWidget);
    expect(find.byKey(Appkeys.signUpModal), findsNothing);

    await tester.tap(find.byKey(Appkeys.switchToSignUpButton));
    await tester.pumpAndSettle();
    expect(find.byKey(Appkeys.signUpModal), findsOneWidget);
    expect(find.byKey(Appkeys.loginModal), findsNothing);

    await tester.tap(find.byKey(Appkeys.switchToLoginButton));
    await tester.pumpAndSettle();
    expect(find.byKey(Appkeys.loginModal), findsOneWidget);
    expect(find.byKey(Appkeys.signUpModal), findsNothing);

    await tester.tap(find.byKey(Appkeys.switchToSignUpButton));
    await tester.pumpAndSettle();
    expect(find.byKey(Appkeys.signUpModal), findsOneWidget);

    await tester.tap(find.byKey(Appkeys.switchToLoginButton));
    await tester.pumpAndSettle();
    expect(find.byKey(Appkeys.loginModal), findsOneWidget);

    expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);
  });

  testWidgets(
    'Guest user cannot comment or like and sees a restriction modal',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);

      await tester.tap(find.byKey(Appkeys.loginAsGuestButton));
      await tester.pumpAndSettle();
      expect(find.byKey(Appkeys.unauthenticatedFooter), findsNothing);
      expect(find.byKey(Appkeys.homePage), findsOneWidget);

      await tester.tap(find.byKey(Appkeys.commentButton).first);
      await tester.pumpAndSettle();
      expect(find.byKey(Appkeys.guestRestrictionModal), findsOneWidget);
      expect(find.byKey(Appkeys.commentModal), findsNothing);
      expect(find.byKey(Appkeys.signUpOrLoginModal), findsNothing);

      Navigator.of(
        tester.element(find.byKey(Appkeys.guestRestrictionModal)),
      ).pop();
      await tester.pumpAndSettle();
      expect(find.byKey(Appkeys.guestRestrictionModal), findsNothing);

      await tester.tap(find.byKey(Appkeys.likeButton).first);
      await tester.pumpAndSettle();
      expect(find.byKey(Appkeys.guestRestrictionModal), findsOneWidget);

      Navigator.of(
        tester.element(find.byKey(Appkeys.guestRestrictionModal)),
      ).pop();
      await tester.pumpAndSettle();

      await logOut(tester);
    },
  );
}
