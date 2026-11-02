import 'package:flutter/foundation.dart';
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
        expect(find.byKey(Appkeys.settingsPage), findsOneWidget);
        expect(find.text(Textconstants.displaynamePlaceholder), findsOneWidget);
        expect(find.text(Textconstants.emailPlaceholder), findsOneWidget);
        expect(find.text(Textconstants.usernamePlaceholder), findsOneWidget);
        await tester.tap(find.byKey(Appkeys.homebutton));
        expect(find.byKey(Appkeys.homePage), findsOneWidget);
        expect(find.byKey(Appkeys.settingsPage), findsNothing);
      },
    );
  });
}
