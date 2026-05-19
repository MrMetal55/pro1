import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro1/main.dart';

void main() {
  group('CalculatorEvaluator', () {
    test('uses multiplication and division precedence', () {
      expect(CalculatorEvaluator.evaluate('2+3×4'), '14');
      expect(CalculatorEvaluator.evaluate('8÷2+3'), '7');
    });

    test('formats decimals and rejects invalid calculations', () {
      expect(CalculatorEvaluator.evaluate('1.5+2.25'), '3.75');
      expect(CalculatorEvaluator.evaluate('5÷0'), 'Error');
      expect(CalculatorEvaluator.evaluate('1+'), 'Error');
    });

    test('supports a leading negative number', () {
      expect(CalculatorEvaluator.evaluate('-5+2'), '-3');
    });

    test('supports parentheses', () {
      expect(CalculatorEvaluator.evaluate('(2+3)×4'), '20');
      expect(CalculatorEvaluator.evaluate('8÷(2+2)'), '2');
      expect(CalculatorEvaluator.evaluate('(1+2'), 'Error');
    });

    test('supports powers', () {
      expect(CalculatorEvaluator.evaluate('2^3'), '8');
      expect(CalculatorEvaluator.evaluate('2+3^2'), '11');
      expect(CalculatorEvaluator.evaluate('(2+3)^2'), '25');
    });
  });

  testWidgets('calculator evaluates a button sequence', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.widgetWithText(FilledButton, '2'));
    await tester.tap(find.widgetWithText(FilledButton, '+'));
    await tester.tap(find.widgetWithText(FilledButton, '3'));
    await tester.tap(find.widgetWithText(FilledButton, '×'));
    await tester.tap(find.widgetWithText(FilledButton, '4'));
    await tester.tap(find.widgetWithText(FilledButton, '='));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('result-display'))).data,
      '14',
    );
    expect(
      tester.widget<Text>(find.byKey(const Key('expression-display'))).data,
      '2+3×4',
    );
  });

  testWidgets('operator after equals starts a new equation with the result', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.widgetWithText(FilledButton, '2'));
    await tester.tap(find.widgetWithText(FilledButton, '+'));
    await tester.tap(find.widgetWithText(FilledButton, '3'));
    await tester.tap(find.widgetWithText(FilledButton, '='));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('expression-display'))).data,
      '2+3',
    );
    expect(
      tester.widget<Text>(find.byKey(const Key('result-display'))).data,
      '5',
    );

    await tester.tap(find.widgetWithText(FilledButton, '×'));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('expression-display'))).data,
      '5×',
    );
    expect(
      tester.widget<Text>(find.byKey(const Key('result-display'))).data,
      '5',
    );
  });

  testWidgets('calculator evaluates a parenthesized button sequence', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.widgetWithText(FilledButton, '('));
    await tester.tap(find.widgetWithText(FilledButton, '2'));
    await tester.tap(find.widgetWithText(FilledButton, '+'));
    await tester.tap(find.widgetWithText(FilledButton, '3'));
    await tester.tap(find.widgetWithText(FilledButton, ')'));
    await tester.tap(find.widgetWithText(FilledButton, '×'));
    await tester.tap(find.widgetWithText(FilledButton, '4'));
    await tester.tap(find.widgetWithText(FilledButton, '='));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('result-display'))).data,
      '20',
    );
  });

  testWidgets('calculator evaluates a power button sequence', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.widgetWithText(FilledButton, '2'));
    await tester.tap(find.widgetWithText(FilledButton, '^'));
    await tester.tap(find.widgetWithText(FilledButton, '3'));
    await tester.tap(find.widgetWithText(FilledButton, '='));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('result-display'))).data,
      '8',
    );
  });

  testWidgets('tapping C deletes the last input', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.widgetWithText(FilledButton, '7'));
    await tester.tap(find.widgetWithText(FilledButton, '8'));
    await tester.tap(find.widgetWithText(FilledButton, 'C'));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('expression-display'))).data,
      '7',
    );
    expect(
      tester.widget<Text>(find.byKey(const Key('result-display'))).data,
      '0',
    );
  });

  testWidgets('long pressing C resets the calculator displays', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.widgetWithText(FilledButton, '7'));
    await tester.tap(find.widgetWithText(FilledButton, '8'));
    await tester.longPress(find.widgetWithText(FilledButton, 'C'));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('expression-display'))).data,
      '0',
    );
    expect(
      tester.widget<Text>(find.byKey(const Key('result-display'))).data,
      '0',
    );
  });

  testWidgets('operator after an error does not append to Error', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.widgetWithText(FilledButton, '5'));
    await tester.tap(find.widgetWithText(FilledButton, '÷'));
    await tester.tap(find.widgetWithText(FilledButton, '0'));
    await tester.tap(find.widgetWithText(FilledButton, '='));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('result-display'))).data,
      'Error',
    );

    await tester.tap(find.widgetWithText(FilledButton, '+'));
    await tester.pump();

    expect(
      tester.widget<Text>(find.byKey(const Key('expression-display'))).data,
      '0',
    );
    expect(
      tester.widget<Text>(find.byKey(const Key('result-display'))).data,
      '0',
    );
  });

  testWidgets('long pressing equals runs a surprise calculation', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.longPress(find.widgetWithText(FilledButton, '='));
    await tester.pump();

    final expression = tester
        .widget<Text>(find.byKey(const Key('expression-display')))
        .data;
    final result = tester
        .widget<Text>(find.byKey(const Key('result-display')))
        .data;

    expect(CalculatorEvaluator.surpriseExpressions, contains(expression));
    expect(result, CalculatorEvaluator.evaluate(expression!));
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
