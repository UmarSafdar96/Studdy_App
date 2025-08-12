import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:welcome_module/welcome_module.dart';

void main() {
  testWidgets('WelcomeScreen displays correctly', (WidgetTester tester) async {
    bool onFinishedCalled = false;
    
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeScreen(
        ),
      ),
    );

    // Verify that the welcome screen is displayed
    expect(find.text('SmartPace'), findsOneWidget);
    expect(find.text('Your Smart Study Companion'), findsOneWidget);
    expect(find.text('Smart Study Planning'), findsOneWidget);
  });
}
