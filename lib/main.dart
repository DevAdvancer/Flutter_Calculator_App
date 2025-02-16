import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String input = '';
  String output = '0';

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
          Parser p = Parser();
          Expression exp = p.parse(input.replaceAll('×', '*').replaceAll('÷', '/'));
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

  Widget buildButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(22),
            backgroundColor: color ?? Colors.grey[700],
          ),
          onPressed: () => onButtonPressed(text),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              // Input Display
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text(
                    input,
                    style: TextStyle(fontSize: 32, color: Colors.white70),
                  ),
                ),
              ),
              // Output Display
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.bottomRight,
                child: Text(
                  output,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              // Buttons
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(children: [
                          buildButton('C', color: Colors.grey),
                          buildButton('⌫', color: Colors.grey),
                          buildButton('(', color: Colors.grey),
                          buildButton(')', color: Colors.grey),
                        ]),
                      ),
                      Expanded(
                        child: Row(children: [
                          buildButton('7'),
                          buildButton('8'),
                          buildButton('9'),
                          buildButton('÷', color: Colors.orange),
                        ]),
                      ),
                      Expanded(
                        child: Row(children: [
                          buildButton('4'),
                          buildButton('5'),
                          buildButton('6'),
                          buildButton('×', color: Colors.orange),
                        ]),
                      ),
                      Expanded(
                        child: Row(children: [
                          buildButton('1'),
                          buildButton('2'),
                          buildButton('3'),
                          buildButton('-', color: Colors.orange),
                        ]),
                      ),
                      Expanded(
                        child: Row(children: [
                          buildButton('0'),
                          buildButton('.'),
                          buildButton('=', color: Colors.orange),
                          buildButton('+', color: Colors.orange),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
