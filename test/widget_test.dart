import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/screens/login_screen.dart';

void main() {
  testWidgets('Login screen has email, password fields, and buttons',
      (WidgetTester tester) async {
    // Build LoginScreen and trigger a frame
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify the email and password fields are present
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    // Verify the Login button is present
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);

    // Verify the Create Account button is present
    expect(find.widgetWithText(TextButton, 'Create Account'), findsOneWidget);
  });
}
