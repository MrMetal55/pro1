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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
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

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '0';
        return;
      }

      if (value == '=') {
        _result = _evaluateExpression(_expression);
        _expression = _result;
        return;
      }

      if (_isOperator(value)) {
        if (_expression.isEmpty) {
          if (value == '-') {
            _expression = '-';
          }
          return;
        }
        if (_isOperator(_expression.characters.last)) {
          _expression =
              _expression.substring(0, _expression.length - 1) + value;
          return;
        }
      }

      if (value == '.' && _expression.isNotEmpty) {
        final lastNumber = _getLastToken(_expression);
        if (lastNumber.contains('.')) {
          return;
        }
      }

      _expression += value;
    });
  }

  bool _isOperator(String value) {
    return value == '+' || value == '-' || value == '×' || value == '÷';
  }

  String _getLastToken(String expression) {
    final buffer = StringBuffer();
    for (var i = expression.length - 1; i >= 0; i--) {
      final char = expression[i];
      if (_isOperator(char)) break;
      buffer.write(char);
    }
    return buffer.toString().split('').reversed.join();
  }

  String _evaluateExpression(String expression) {
    if (expression.isEmpty) return '0';

    final tokens = <String>[];
    final buffer = StringBuffer();

    for (var i = 0; i < expression.length; i++) {
      final char = expression[i];
      if (_isOperator(char)) {
        if (buffer.isNotEmpty) {
          tokens.add(buffer.toString());
          buffer.clear();
        }
        tokens.add(char);
      } else {
        buffer.write(char);
      }
    }
    if (buffer.isNotEmpty) {
      tokens.add(buffer.toString());
    }

    if (tokens.isEmpty) return '0';

    try {
      final precedenceTokens = <String>[];
      var index = 0;
      while (index < tokens.length) {
        final token = tokens[index];
        if (token == '×' || token == '÷') {
          final left = double.parse(precedenceTokens.removeLast());
          final right = double.parse(tokens[index + 1]);
          final result = token == '×' ? left * right : left / right;
          precedenceTokens.add(result.toString());
          index += 2;
        } else {
          precedenceTokens.add(token);
          index += 1;
        }
      }

      var total = double.parse(precedenceTokens[0]);
      index = 1;
      while (index < precedenceTokens.length) {
        final op = precedenceTokens[index];
        final next = double.parse(precedenceTokens[index + 1]);
        if (op == '+') {
          total += next;
        } else if (op == '-') {
          total -= next;
        }
        index += 2;
      }

      final resultString = total
          .toStringAsFixed(10)
          .replaceFirst(RegExp(r'\.0+'), '');
      return resultString;
    } catch (_) {
      return 'Error';
    }
  }

  Widget _buildButton(String label, {Color? color, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: FilledButton(
        onPressed: () => _onButtonPressed(label),
        style: FilledButton.styleFrom(
          backgroundColor:
              color ?? Theme.of(context).colorScheme.secondaryContainer,
          foregroundColor:
              textColor ?? Theme.of(context).colorScheme.onSecondaryContainer,
          minimumSize: const Size(72, 72),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              color: Theme.of(context).colorScheme.primaryContainer,
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression.isEmpty ? '0' : _expression,
                    style: const TextStyle(fontSize: 34, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _result,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildButton(
                        'C',
                        color: Colors.white,
                        textColor: Colors.pinkAccent[200],
                      ),
                    ),
                    Expanded(
                      child: _buildButton(
                        '÷',
                        color: Colors.deepPurpleAccent,
                        textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: _buildButton(
                        '×',
                        color: Colors.deepPurpleAccent,
                        textColor: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: _buildButton(
                        '-',
                        color: Colors.deepPurpleAccent,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildButton('7')),
                    Expanded(child: _buildButton('8')),
                    Expanded(child: _buildButton('9')),
                    Expanded(
                      child: _buildButton(
                        '+',
                        color: Colors.deepPurpleAccent,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildButton('4')),
                    Expanded(child: _buildButton('5')),
                    Expanded(child: _buildButton('6')),
                    Expanded(child: _buildButton('1')),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _buildButton('2')),
                    Expanded(child: _buildButton('3')),
                    Expanded(child: _buildButton('0')),
                    Expanded(
                      child: _buildButton(
                        '.',
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FilledButton(
                          onPressed: () => _onButtonPressed('='),
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(72, 72),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Text(
                            '=',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
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
    );
  }
}
