import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/main.dart';

void main() {
  testWidgets('Calculator App Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CalculatorApp());

    // Verify that the initial output is '0'.
    expect(find.text('0'), findsOneWidget);

    // Tap the '7' button and verify the input and output.
    await tester.tap(find.text('7'));
    await tester.pump();
    expect(find.text('7'), findsOneWidget);

    // Tap the '8' button and verify the input and output.
    await tester.tap(find.text('8'));
    await tester.pump();
    expect(find.text('78'), findsOneWidget);

    // Tap the '+' button and verify the input.
    await tester.tap(find.text('+'));
    await tester.pump();
    expect(find.text('78+'), findsOneWidget);

    // Tap the '6' button and verify the input.
    await tester.tap(find.text('6'));
    await tester.pump();
    expect(find.text('78+6'), findsOneWidget);

    // Tap the '3' button and verify the input.
    await tester.tap(find.text('3'));
    await tester.pump();
    expect(find.text('78+63'), findsOneWidget);

    // Tap the '=' button and verify the output.
    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('141'), findsOneWidget);

    // Tap the 'AC' button and verify the input and output are reset.
    await tester.tap(find.text('C'));
    await tester.pump();
    expect(find.text(''), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });
}
