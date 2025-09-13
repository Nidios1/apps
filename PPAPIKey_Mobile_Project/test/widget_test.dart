import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ppapikey_mobile/main.dart';

void main() {
  testWidgets('App should start with login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp(prefs: null));

    // Verify that login screen is displayed
    expect(find.text('PPAPIKey Mobile'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}