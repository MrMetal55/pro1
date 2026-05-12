import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '0';
  bool _justEvaluated = false;
  final _random = Random();

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
        _result = '0';
        _justEvaluated = false;
        return;
      }

      if (value == '=') {
        _result = CalculatorEvaluator.evaluate(_expression);
        _justEvaluated = true;
        return;
      }

      if (_isOperator(value)) {
        if (_justEvaluated && _result == 'Error') {
          _expression = value == '-' ? '-' : '';
          _result = '0';
          _justEvaluated = false;
          return;
        }

        if (_justEvaluated) {
          _expression = _result;
        }

        _justEvaluated = false;
        if (_expression.isEmpty) {
          if (value == '-') {
            _expression = '-';
          }
          return;
        }
        if (_expression == '-') {
          return;
        }
        if (_expression.characters.last == '(' && value != '-') {
          return;
        }
        if (_isOperator(_expression.characters.last)) {
          _expression =
              _expression.substring(0, _expression.length - 1) + value;
          return;
        }
      }

      if (!_isOperator(value) && _justEvaluated) {
        _expression = '';
        _result = '0';
        _justEvaluated = false;
      }

      if (value == '(') {
        if (_expression.isNotEmpty &&
            !_isOperator(_expression.characters.last) &&
            _expression.characters.last != '(') {
          return;
        }
      }

      if (value == ')') {
        if (_expression.isEmpty ||
            _isOperator(_expression.characters.last) ||
            _expression.characters.last == '(') {
          return;
        }
      }

      if (value == '.') {
        final lastNumber = CalculatorEvaluator.getLastToken(_expression);
        if (lastNumber.contains('.')) {
          return;
        }
        if (_expression.isEmpty ||
            _isOperator(_expression.characters.last) ||
            _expression.characters.last == '(') {
          _expression += '0';
        }
      }

      _expression += value;
    });
  }

  void _runSurpriseCalculation() {
    final expression =
        CalculatorEvaluator.surpriseExpressions[_random.nextInt(
          CalculatorEvaluator.surpriseExpressions.length,
        )];
    final result = CalculatorEvaluator.evaluate(expression);

    setState(() {
      _expression = expression;
      _result = result;
      _justEvaluated = true;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Ueberraschung: $expression = $result'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void _resetCalculator() {
    setState(() {
      _expression = '';
      _result = '0';
      _justEvaluated = false;
    });
  }

  bool _isOperator(String value) {
    return CalculatorEvaluator.isOperator(value);
  }

  Widget _buildButton(
    String label, {
    Color? color,
    Color? textColor,
    double fontSize = 28,
    VoidCallback? onLongPress,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: SizedBox.square(
          dimension: 66,
          child: FilledButton(
            onPressed: () => _onButtonPressed(label),
            onLongPress: onLongPress,
            style: FilledButton.styleFrom(
              backgroundColor: color ?? const Color(0xFFE0E0E0),
              foregroundColor: textColor ?? Colors.black,
              padding: EdgeInsets.zero,
              shape: const CircleBorder(),
            ),
            child: Text(
              label,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonCell(
    String label, {
    Color? color,
    Color? textColor,
    double fontSize = 28,
    int flex = 1,
    VoidCallback? onLongPress,
  }) {
    return Expanded(
      flex: flex,
      child: _buildButton(
        label,
        color: color,
        textColor: textColor,
        fontSize: fontSize,
        onLongPress: onLongPress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                color: Colors.black,
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _expression.isEmpty ? '0' : _expression,
                        key: const Key('expression-display'),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 34,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _result,
                        key: const Key('result-display'),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButtonCell(
                        'C',
                        color: Colors.grey.shade800,
                        textColor: Colors.white,
                        onLongPress: _resetCalculator,
                      ),
                      _buildButtonCell(
                        '(',
                        color: Colors.orange,
                        textColor: Colors.white,
                        fontSize: 30,
                      ),
                      _buildButtonCell(
                        ')',
                        color: Colors.orange,
                        textColor: Colors.white,
                        fontSize: 30,
                      ),
                      _buildButtonCell(
                        '÷',
                        color: Colors.orange,
                        textColor: Colors.white,
                        fontSize: 32,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButtonCell('7'),
                      _buildButtonCell('8'),
                      _buildButtonCell('9'),
                      _buildButtonCell(
                        '×',
                        color: Colors.orange,
                        textColor: Colors.white,
                        fontSize: 32,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButtonCell('4'),
                      _buildButtonCell('5'),
                      _buildButtonCell('6'),
                      _buildButtonCell(
                        '-',
                        color: Colors.orange,
                        textColor: Colors.white,
                        fontSize: 32,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButtonCell('1'),
                      _buildButtonCell('2'),
                      _buildButtonCell('3'),
                      _buildButtonCell(
                        '+',
                        color: Colors.orange,
                        textColor: Colors.white,
                        fontSize: 32,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButtonCell(
                        '.',
                        color: Colors.grey.shade800,
                        textColor: Colors.white,
                        fontSize: 30,
                      ),
                      _buildButtonCell('0'),
                      _buildButtonCell(
                        '^',
                        color: Colors.orange,
                        textColor: Colors.white,
                        fontSize: 30,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: SizedBox.square(
                              dimension: 66,
                              child: FilledButton(
                                onPressed: () => _onButtonPressed('='),
                                onLongPress: _runSurpriseCalculation,
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                  shape: const CircleBorder(),
                                ),
                                child: const Text(
                                  '=',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorEvaluator {
  const CalculatorEvaluator._();

  static const surpriseExpressions = [
    '(7+5)×3',
    '9×9-7',
    '2^5',
    '(8÷2+6)×4',
    '12×3+6',
    '(5+5)×(2+3)',
  ];

  static bool isOperator(String value) {
    return value == '+' ||
        value == '-' ||
        value == '×' ||
        value == '÷' ||
        value == '^';
  }

  static String getLastToken(String expression) {
    final buffer = StringBuffer();
    for (var i = expression.length - 1; i >= 0; i--) {
      final char = expression[i];
      if (isOperator(char) || char == '(' || char == ')') {
        if (char == '-' && (i == 0 || isOperator(expression[i - 1]))) {
          buffer.write(char);
        }
        break;
      }
      buffer.write(char);
    }
    return buffer.toString().split('').reversed.join();
  }

  static String evaluate(String expression) {
    if (expression.isEmpty) return '0';
    final lastChar = expression.characters.last;
    if (isOperator(lastChar) || lastChar == '(') return 'Error';

    try {
      final parser = _ExpressionParser(expression);
      final total = parser.parse();
      if (!total.isFinite) return 'Error';
      final resultString = total
          .toStringAsFixed(10)
          .replaceFirst(RegExp(r'\.?0+$'), '');
      return resultString;
    } catch (_) {
      return 'Error';
    }
  }
}

class _ExpressionParser {
  _ExpressionParser(this.expression);

  final String expression;
  var _index = 0;

  double parse() {
    final value = _parseExpression();
    if (_index != expression.length) {
      throw const FormatException('Unexpected input');
    }
    return value;
  }

  double _parseExpression() {
    var value = _parseTerm();
    while (_match('+') || _match('-')) {
      final operator = expression[_index - 1];
      final next = _parseTerm();
      value = operator == '+' ? value + next : value - next;
    }
    return value;
  }

  double _parseTerm() {
    var value = _parsePower();
    while (_match('×') || _match('÷')) {
      final operator = expression[_index - 1];
      final next = _parsePower();
      if (operator == '÷' && next == 0) {
        throw const FormatException('Division by zero');
      }
      value = operator == '×' ? value * next : value / next;
    }
    return value;
  }

  double _parsePower() {
    final base = _parseFactor();
    if (_match('^')) {
      final exponent = _parsePower();
      return pow(base, exponent).toDouble();
    }
    return base;
  }

  double _parseFactor() {
    if (_match('-')) {
      return -_parseFactor();
    }

    if (_match('(')) {
      final value = _parseExpression();
      if (!_match(')')) {
        throw const FormatException('Missing closing parenthesis');
      }
      return value;
    }

    return _parseNumber();
  }

  double _parseNumber() {
    final start = _index;
    var hasDecimalPoint = false;

    while (_index < expression.length) {
      final char = expression[_index];
      if (char == '.') {
        if (hasDecimalPoint) break;
        hasDecimalPoint = true;
        _index += 1;
      } else if (_isDigit(char)) {
        _index += 1;
      } else {
        break;
      }
    }

    if (start == _index) {
      throw const FormatException('Expected number');
    }
    return double.parse(expression.substring(start, _index));
  }

  bool _match(String char) {
    if (_index < expression.length && expression[_index] == char) {
      _index += 1;
      return true;
    }
    return false;
  }

  bool _isDigit(String char) {
    return char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
  }
}
