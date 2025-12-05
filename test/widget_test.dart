import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/main.dart';

void main() {
  testWidgets('Test 2+2 = 4', (WidgetTester tester) async {
    await tester.pumpWidget(CalculatorApp());

    await tester.tap(find.widgetWithText(ElevatedButton, '2').first);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '+').first);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '2').first);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();

    expect(find.text('2+2'), findsOneWidget);
    expect(find.text('4'), findsAtLeastNWidgets(1));
  });

  testWidgets('Test 10/4 = 2.5', (WidgetTester tester) async {
    await tester.pumpWidget(CalculatorApp());

    await tester.tap(find.widgetWithText(ElevatedButton, '1'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '0').first);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '÷'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '4'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();

    expect(find.text('10÷4'), findsOneWidget);
    expect(find.text('2.5'), findsOneWidget);
  });

  testWidgets('Test (2+3)*4 = 20', (WidgetTester tester) async {
    await tester.pumpWidget(CalculatorApp());

    await tester.tap(find.widgetWithText(ElevatedButton, '('));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '2').first);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '+').first);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '3'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, ')'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '×'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '4'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();

    expect(find.text('(2+3)×4'), findsOneWidget);
    expect(find.text('20'), findsAtLeastNWidgets(1));
  });

  testWidgets('Test empty input returns 0', (WidgetTester tester) async {
    await tester.pumpWidget(CalculatorApp());

    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();

    expect(find.text('0'), findsAtLeastNWidgets(1));
  });

  testWidgets('Test clear button', (WidgetTester tester) async {
    await tester.pumpWidget(CalculatorApp());

    await tester.tap(find.widgetWithText(ElevatedButton, '5'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '+').first);
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '3'));
    await tester.pump();

    expect(find.text('5+3'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'C'));
    await tester.pump();

    expect(find.text('0'), findsAtLeastNWidgets(1));
  });
}
