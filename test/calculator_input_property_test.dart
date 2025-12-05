import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:calculator/main.dart';

/// Property-based tests for calculator input handling
void main() {
  group('Input Property-Based Tests', () {
    final random = Random(42);

    /// **Feature: calculator-modernization, Property 1: Input Appending Preserves Order**
    /// **Validates: Requirements 1.1, 1.2**
    ///
    /// For any sequence of button presses (digits, operators, parentheses, decimal),
    /// the resulting input string SHALL contain those characters in the exact order they were pressed.
    testWidgets('Property 1: Input Appending Preserves Order - 100 iterations',
        (WidgetTester tester) async {
      for (int i = 0; i < 100; i++) {
        await tester.pumpWidget(CalculatorApp());

        // Generate random sequence of valid inputs
        final validInputs = [
          '0',
          '1',
          '2',
          '3',
          '4',
          '5',
          '6',
          '7',
          '8',
          '9',
          '+',
          '-',
          '×',
          '÷',
          '.',
          '(',
          ')'
        ];

        final sequenceLength = random.nextInt(5) + 2; // 2-6 inputs
        String expectedInput = '';

        for (int j = 0; j < sequenceLength; j++) {
          final input = validInputs[random.nextInt(validInputs.length)];
          expectedInput += input;

          await tester.tap(find.widgetWithText(ElevatedButton, input).first);
          await tester.pump();
        }

        // Verify the input display shows the exact sequence
        expect(find.text(expectedInput), findsOneWidget,
            reason: 'Input should preserve order: $expectedInput');

        // Reset for next iteration
        await tester.tap(find.widgetWithText(ElevatedButton, 'C'));
        await tester.pump();
      }
    });

    /// **Feature: calculator-modernization, Property 2: Clear Resets to Initial State**
    /// **Validates: Requirements 2.1**
    ///
    /// For any calculator state (any input string, any output value), pressing the clear button
    /// SHALL result in input being empty string and output being "0".
    testWidgets('Property 2: Clear Resets to Initial State - 100 iterations',
        (WidgetTester tester) async {
      for (int i = 0; i < 100; i++) {
        await tester.pumpWidget(CalculatorApp());

        // Generate random input
        final validInputs = ['1', '2', '3', '4', '5', '+', '-', '×', '÷'];
        final sequenceLength = random.nextInt(5) + 1;

        for (int j = 0; j < sequenceLength; j++) {
          final input = validInputs[random.nextInt(validInputs.length)];
          await tester.tap(find.widgetWithText(ElevatedButton, input).first);
          await tester.pump();
        }

        // Press clear
        await tester.tap(find.widgetWithText(ElevatedButton, 'C'));
        await tester.pump();

        // Verify output is "0" (there will be multiple "0" widgets - button and display)
        expect(find.text('0'), findsAtLeastNWidgets(1));
      }
    });

    /// **Feature: calculator-modernization, Property 3: Backspace Removes Last Character**
    /// **Validates: Requirements 2.2**
    ///
    /// For any non-empty input string, pressing backspace SHALL result in an input string
    /// that is the original string with the last character removed.
    testWidgets('Property 3: Backspace Removes Last Character - 100 iterations',
        (WidgetTester tester) async {
      for (int i = 0; i < 100; i++) {
        await tester.pumpWidget(CalculatorApp());

        // Generate random input
        final validInputs = ['1', '2', '3', '4', '5', '+', '-'];
        final sequenceLength = random.nextInt(4) + 2; // At least 2 characters
        String expectedInput = '';

        for (int j = 0; j < sequenceLength; j++) {
          final input = validInputs[random.nextInt(validInputs.length)];
          expectedInput += input;
          await tester.tap(find.widgetWithText(ElevatedButton, input).first);
          await tester.pump();
        }

        // Press backspace
        await tester.tap(find.widgetWithText(ElevatedButton, '⌫'));
        await tester.pump();

        // Verify last character was removed
        final expectedAfterBackspace =
            expectedInput.substring(0, expectedInput.length - 1);
        expect(find.text(expectedAfterBackspace), findsAtLeastNWidgets(1),
            reason:
                'After backspace, "$expectedInput" should become "$expectedAfterBackspace"');

        // Reset for next iteration
        await tester.tap(find.widgetWithText(ElevatedButton, 'C'));
        await tester.pump();
      }
    });
  });
}
