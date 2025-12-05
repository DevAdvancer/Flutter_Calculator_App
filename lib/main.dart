import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          surface: Color(0xFFF2F2F7),
          primary: Color(0xFFFF9500),
          secondary: Color(0xFFE5E5EA),
          onSurface: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          surface: Color(0xFF1C1C1E),
          primary: Color(0xFFFF9500),
          secondary: Color(0xFF636366),
          onSurface: Colors.white,
        ),
      ),
      themeMode: ThemeMode.system,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String output = '0';

  // Constants
  static const double _buttonBorderRadius = 16.0;
  static const double _buttonPadding = 24.0;
  static const double _buttonSpacing = 8.0;
  static const double _inputFontSize = 28.0;
  static const double _outputFontSize = 56.0;
  static const double _inputOpacity = 0.6;

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        output = '0';
      } else if (value == '⌫') {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : '';
      } else if (value == '=') {
        if (input.isEmpty) {
          output = '0';
          return;
        }
        try {
          GrammarParser p = GrammarParser();
          Expression exp =
              p.parse(input.replaceAll('×', '*').replaceAll('÷', '/'));
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          // Handle division by zero
          if (eval.isInfinite || eval.isNaN) {
            output = 'Error';
          } else {
            output = eval % 1 == 0 ? eval.toInt().toString() : eval.toString();
          }
        } catch (e) {
          output = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  Widget buildButton(String text, Color backgroundColor, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(_buttonSpacing),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_buttonBorderRadius),
            ),
            padding: EdgeInsets.all(_buttonPadding),
            elevation: 0,
            backgroundColor: backgroundColor,
            minimumSize: Size(48, 48),
          ),
          onPressed: () => onButtonPressed(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Input Display
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Text(
                  input,
                  style: TextStyle(
                    fontSize: _inputFontSize,
                    color: colorScheme.onSurface.withOpacity(_inputOpacity),
                  ),
                ),
              ),
            ),
            // Output Display
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: TextStyle(
                  fontSize: _outputFontSize,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            // Buttons
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(_buttonSpacing),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        buildButton(
                            'C', colorScheme.secondary, colorScheme.onSurface),
                        buildButton(
                            '⌫', colorScheme.secondary, colorScheme.onSurface),
                        buildButton(
                            '(', colorScheme.secondary, colorScheme.onSurface),
                        buildButton(
                            ')', colorScheme.secondary, colorScheme.onSurface),
                      ]),
                    ),
                    Expanded(
                      child: Row(children: [
                        buildButton(
                            '7', colorScheme.surface, colorScheme.onSurface),
                        buildButton(
                            '8', colorScheme.surface, colorScheme.onSurface),
                        buildButton(
                            '9', colorScheme.surface, colorScheme.onSurface),
                        buildButton('÷', colorScheme.primary, Colors.white),
                      ]),
                    ),
                    Expanded(
                      child: Row(children: [
                        buildButton(
                            '4', colorScheme.surface, colorScheme.onSurface),
                        buildButton(
                            '5', colorScheme.surface, colorScheme.onSurface),
                        buildButton(
                            '6', colorScheme.surface, colorScheme.onSurface),
                        buildButton('×', colorScheme.primary, Colors.white),
                      ]),
                    ),
                    Expanded(
                      child: Row(children: [
                        buildButton(
                            '1', colorScheme.surface, colorScheme.onSurface),
                        buildButton(
                            '2', colorScheme.surface, colorScheme.onSurface),
                        buildButton(
                            '3', colorScheme.surface, colorScheme.onSurface),
                        buildButton('-', colorScheme.primary, Colors.white),
                      ]),
                    ),
                    Expanded(
                      child: Row(children: [
                        buildButton(
                            '0', colorScheme.surface, colorScheme.onSurface),
                        buildButton(
                            '.', colorScheme.surface, colorScheme.onSurface),
                        buildButton('=', colorScheme.primary, Colors.white),
                        buildButton('+', colorScheme.primary, Colors.white),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
