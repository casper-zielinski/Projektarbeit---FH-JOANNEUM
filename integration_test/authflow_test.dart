import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/constants/appkeys.dart';
import 'package:flutterapp/constants/textconstants.dart';
import 'package:flutterapp/main.dart';
import 'package:integration_test/integration_test.dart';

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

        expect(find.byKey(Appkeys.settingsPage), findsOneWidget);
        expect(find.text(Textconstants.displaynamePlaceholder), findsOneWidget);
        expect(find.text(Textconstants.emailPlaceholder), findsOneWidget);
        expect(find.text(Textconstants.usernamePlaceholder), findsOneWidget);
        await tester.tap(find.byKey(Appkeys.homebutton));
        await tester.pumpAndSettle();
        expect(find.byKey(Appkeys.homePage), findsOneWidget);
        expect(find.byKey(Appkeys.settingsPage), findsNothing);
      },
    );

    testWidgets("Unauthenticated User Sign's Up and Logs out", (tester) async {
      final String username = "John";
      final String email = "john.doe@gmail.com";
      final String password = "secret1!";

      await tester.pumpWidget(const MyApp());
      expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);

      await tester.tap(find.byKey(Appkeys.opensignUpModalButton));
      await tester.pumpAndSettle();
      expect(find.byKey(Appkeys.signUpModal), findsOneWidget);
      await tester.enterText(find.byKey(Appkeys.usernameTextField), username);
      await tester.enterText(find.byKey(Appkeys.emailTextField), email);
      await tester.enterText(find.byKey(Appkeys.passwordTextField), password);
      await tester.tap(find.byKey(Appkeys.signUpButton));
      await tester.pumpAndSettle();

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

      await tester.tap(find.byKey(Appkeys.logoutButton));
      await tester.pumpAndSettle();
      expect(find.byKey(Appkeys.unauthenticatedFooter), findsOneWidget);
    });
  });
}
