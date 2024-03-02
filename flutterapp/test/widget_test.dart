import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/main.dart';

void main() {
  testWidgets('MyApp UI Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TravelApp(),
      ),
    ));

    // Verify that the title is rendered correctly.
    expect(find.text('Tourism Recommendation System'), findsOneWidget);

    // You can add more test cases to verify other parts of your UI.
  });
}
