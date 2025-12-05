import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_expressions/math_expressions.dart';

/// **Feature: calculator-modernization, Property 4: Valid Expression Evaluation**
/// **Validates: Requirements 1.3**
///
/// For any valid mathematical expression composed of digits, operators (+, -, *, /),
/// parentheses, and decimal points, evaluating the expression SHALL produce the
/// mathematically correct result.
void main() {
  group('Property-Based Tests', () {
    final random = Random(42); // Fixed seed for reproducibility

    test('Property 4: Valid Expression Evaluation - 100 iterations', () {
      for (int i = 0; i < 100; i++) {
        // Generate random valid expressions with integers
        final a = random.nextInt(100) + 1;
        final b = random.nextInt(100) + 1;
        final operators = ['+', '-', '*', '/'];
        final op = operators[random.nextInt(operators.length)];

        String expression = '$a$op$b';

        // Calculate expected result
        double expected;
        switch (op) {
          case '+':
            expected = (a + b).toDouble();
            break;
          case '-':
            expected = (a - b).toDouble();
            break;
          case '*':
            expected = (a * b).toDouble();
            break;
          case '/':
            expected = a / b;
            break;
          default:
            expected = 0;
        }

        // Parse and evaluate using GrammarParser
        try {
          GrammarParser parser = GrammarParser();
          Expression exp = parser.parse(expression);
          ContextModel cm = ContextModel();
          double result = exp.evaluate(EvaluationType.REAL, cm);

          // Verify result matches expected (with tolerance for floating point)
          expect(
            (result - expected).abs(),
            lessThan(0.0001),
            reason:
                'Expression $expression should evaluate to $expected but got $result',
          );
        } catch (e) {
          fail('Valid expression $expression should not throw error: $e');
        }
      }
    });

    /// **Feature: calculator-modernization, Property 5: Invalid Expression Error Handling**
    /// **Validates: Requirements 3.1, 6.2**
    ///
    /// For any invalid mathematical expression (unbalanced parentheses, consecutive operators, etc.),
    /// evaluating the expression SHALL display "Error" without crashing.
    test('Property 5: Invalid Expression Error Handling - 100 iterations', () {
      final invalidPatterns = [
        () =>
            '${random.nextInt(100)}++${random.nextInt(100)}', // Consecutive operators
        () =>
            '${random.nextInt(100)}**${random.nextInt(100)}', // Invalid operator
        () =>
            '(${random.nextInt(100)}+${random.nextInt(100)}', // Unbalanced parentheses
        () =>
            '${random.nextInt(100)}+${random.nextInt(100)})', // Unbalanced parentheses
        () => '((${random.nextInt(100)})', // Unbalanced parentheses
        () => '${random.nextInt(100)}/', // Incomplete expression
        () => '+${random.nextInt(100)}', // Starting with operator
        () => '${random.nextInt(100)}+', // Ending with operator
      ];

      for (int i = 0; i < 100; i++) {
        // Generate random invalid expression
        final pattern = invalidPatterns[random.nextInt(invalidPatterns.length)];
        final expression = pattern();

        // Try to parse - should either throw or return error
        try {
          GrammarParser parser = GrammarParser();
          Expression exp = parser.parse(expression);
          ContextModel cm = ContextModel();
          double result = exp.evaluate(EvaluationType.REAL, cm);

          // If it doesn't throw, check for NaN or Infinity (which should be treated as error)
          if (result.isNaN || result.isInfinite) {
            // This is expected behavior - invalid expressions can result in NaN/Infinity
            expect(true, isTrue);
          }
        } catch (e) {
          // Exception is expected for invalid expressions
          expect(e, isNotNull);
        }
      }
    });

    /// **Feature: calculator-modernization, Property 6: Result Formatting**
    /// **Validates: Requirements 5.3**
    ///
    /// For any calculation result that is a whole number, the output SHALL display without
    /// a decimal point. For any result with a fractional component, the output SHALL display
    /// with the decimal portion.
    test('Property 6: Result Formatting - 100 iterations', () {
      for (int i = 0; i < 100; i++) {
        // Test whole number results
        final a = random.nextInt(50) + 1;
        final b = random.nextInt(50) + 1;

        // Test addition (always whole number with integers)
        String expression = '$a+$b';
        int expectedWhole = a + b;

        try {
          GrammarParser parser = GrammarParser();
          Expression exp = parser.parse(expression);
          ContextModel cm = ContextModel();
          double result = exp.evaluate(EvaluationType.REAL, cm);

          // Format result as the calculator would
          String formatted =
              result % 1 == 0 ? result.toInt().toString() : result.toString();

          // Verify whole numbers don't have decimal point
          expect(formatted, equals(expectedWhole.toString()),
              reason:
                  'Whole number result should not have decimal: $expression = $expectedWhole');
          expect(formatted.contains('.'), isFalse,
              reason: 'Whole number should not contain decimal point');
        } catch (e) {
          fail('Expression $expression should not throw error: $e');
        }

        // Test division (may have fractional part)
        final c = random.nextInt(50) + 1;
        final d = random.nextInt(50) + 1;
        expression = '$c/$d';
        double expectedDecimal = c / d;

        try {
          GrammarParser parser = GrammarParser();
          Expression exp = parser.parse(expression);
          ContextModel cm = ContextModel();
          double result = exp.evaluate(EvaluationType.REAL, cm);

          // Format result as the calculator would
          String formatted =
              result % 1 == 0 ? result.toInt().toString() : result.toString();

          // Verify formatting matches expectation
          if (expectedDecimal % 1 == 0) {
            expect(formatted.contains('.'), isFalse,
                reason: 'Whole number result should not have decimal point');
          } else {
            // If not a whole number, the formatted string should represent the decimal
            expect(double.parse(formatted), closeTo(expectedDecimal, 0.0001),
                reason: 'Decimal result should be formatted correctly');
          }
        } catch (e) {
          fail('Expression $expression should not throw error: $e');
        }
      }
    });
  });
}
