import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/textconstants.dart';
import 'package:flutterapp/firebase_options.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/service/authservice.dart';
import 'package:integration_test/integration_test.dart';

import 'util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const hostOverride = String.fromEnvironment('EMULATOR_HOST');
  final emulatorHost = hostOverride.isNotEmpty
      ? hostOverride
      : (!kIsWeb && Platform.isAndroid ? '127.0.0.2' : '127.0.0.1');

  setUpAll(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);

    // The emulator starts empty, so the guest account used by
    // "Login as Guest" has to be created first.
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: AuthService.guestUserEmail,
        password: AuthService.guestUserPassword,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code != 'email-already-in-use') rethrow;
    }
    await FirebaseAuth.instance.signOut();
  });

  setUp(() async {
    // AuthService.signOut also resets the static Authorized flags, so a failed
    // test cannot leak its (guest/authenticated) state into the next one.
    await AuthService().signOut();
  });

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
      final String username = "JohnDoe";
      final String email =
          "john.${DateTime.now().millisecondsSinceEpoch}@example.com";
      final String password = "secret1234!";

      await tester.pumpWidget(const MyApp());
      expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);

      await tester.tap(find.byKey(Appkeys.openSignUpModalButton));
      await tester.pumpAndSettle();

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
      expect(settingsFieldText(tester, Appkeys.displayName), username);
      expect(settingsFieldText(tester, Appkeys.email), email);

      await logOut(tester);
    });

    testWidgets('User signs up, logs out, logs in again and logs out', (
      tester,
    ) async {
      final String username = 'JaneDoe';
      final String email =
          'jane.${DateTime.now().millisecondsSinceEpoch}@example.com';
      final String password = 'secret1234!';

      await tester.pumpWidget(const MyApp());
      expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);

      await tester.tap(find.byKey(Appkeys.openSignUpModalButton));
      await tester.pumpAndSettle();
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
      expect(settingsFieldText(tester, Appkeys.displayName), username);
      expect(settingsFieldText(tester, Appkeys.email), email);

      await logOut(tester);
    });

    testWidgets('Password visibility can be toggled in the login modal', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.byKey(Appkeys.openLoginModalButton));
      await tester.pumpAndSettle();
      expect(find.byKey(Appkeys.loginModal), findsOneWidget);

      await tester.enterText(find.byKey(Appkeys.passwordTextField), 'secret1234!');
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
        final String username = 'CarlDoe';
        final String email =
            'carl.${DateTime.now().millisecondsSinceEpoch}@example.com';
        final String password = 'secret1234!';

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
      await pumpUntil(
        tester,
        () => find.byKey(Appkeys.unauthenticatedFooter).evaluate().isEmpty,
        reason: 'guest login to finish',
      );
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
