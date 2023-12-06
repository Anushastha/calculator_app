import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../app/common/buttons_view.dart';

class CalculatorView extends StatefulWidget {
  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  var userQuestion = '';
  var result = '';

  final List<String> buttons = [
    'C', '+/-', '/', '<-',
    '7', '8', '9', '*',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '%','0', '.', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height*0.12,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.deepPurple.shade200,
                  width: 2.0,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      userQuestion,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      result,
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 0.8,
              ),
              itemCount: buttons.length,
              itemBuilder: (BuildContext context, int index) {
                return ButtonsView(
                  buttonText: buttons[index],
                  buttonTapped: () => handleButtonTap(buttons[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void handleButtonTap(String buttonText) {
    setState(() {
      if (result.isNotEmpty) {
        userQuestion = '';
        result = '';
      }
      if (buttonText == 'C') {
        userQuestion = '';
      } else if (buttonText == '<-') {
        userQuestion = userQuestion.substring(0, userQuestion.length - 1);
      } else if (buttonText == '=') {
        result = calculate();
      }else if (buttonText == '+/-') {
        userQuestion = (userQuestion.startsWith('-'))
            ? userQuestion.substring(1)
            : '-' + userQuestion;
      } else {
        userQuestion += buttonText;
      }
    });
  }

  String calculate() {
    try {
      var exp = Parser().parse(userQuestion);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      if (evaluation % 1 == 0) {
        return evaluation.toInt().toString();
      }
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}