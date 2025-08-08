import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulsing_border/pulsing_border.dart';

void main() {
  group('PulsingBorderController', () {
    test('should initialize with default value', () {
      final controller = PulsingBorderController();
      expect(controller.value, false);
      expect(controller.isPulsing, false);
    });

    test('should initialize with custom value', () {
      final controller = PulsingBorderController(isPulsing: true);
      expect(controller.value, true);
      expect(controller.isPulsing, true);
    });

    test('should start pulsing', () {
      final controller = PulsingBorderController();
      controller.startPulsing();
      expect(controller.value, true);
      expect(controller.isPulsing, true);
    });

    test('should stop pulsing', () {
      final controller = PulsingBorderController(isPulsing: true);
      controller.stopPulsing();
      expect(controller.value, false);
      expect(controller.isPulsing, false);
    });

    test('should toggle pulsing', () {
      final controller = PulsingBorderController();

      controller.togglePulsing();
      expect(controller.value, true);
      expect(controller.isPulsing, true);

      controller.togglePulsing();
      expect(controller.value, false);
      expect(controller.isPulsing, false);
    });

    test('should notify listeners when value changes', () {
      final controller = PulsingBorderController();
      bool wasNotified = false;

      controller.addListener(() {
        wasNotified = true;
      });

      controller.startPulsing();
      expect(wasNotified, true);
    });
  });

  group('PulsingBorder Widget', () {
    testWidgets('should render with controller', (WidgetTester tester) async {
      final controller = PulsingBorderController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PulsingBorder(
              color: Colors.red,
              borderRadius: 8,
              controller: controller,
              child: Container(width: 100, height: 50, color: Colors.blue),
            ),
          ),
        ),
      );

      expect(find.byType(PulsingBorder), findsOneWidget);
      expect(
        find.byType(Container),
        findsNWidgets(2),
      ); // One for the border, one for the child
    });

    testWidgets('should start pulsing when controller is set to true', (
      WidgetTester tester,
    ) async {
      final controller = PulsingBorderController(isPulsing: true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PulsingBorder(
              color: Colors.red,
              borderRadius: 8,
              controller: controller,
              child: Container(width: 100, height: 50, color: Colors.blue),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
    });

    testWidgets(
      'should update spreadRadius and blurRadius when parameters change',
      (WidgetTester tester) async {
        final controller = PulsingBorderController(isPulsing: true);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PulsingBorder(
                color: Colors.red,
                borderRadius: 8,
                controller: controller,
                spreadRadius: 8,
                blurRadius: 1,
                child: Container(width: 100, height: 50, color: Colors.blue),
              ),
            ),
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PulsingBorder(
                color: Colors.red,
                borderRadius: 8,
                controller: controller,
                spreadRadius: 16, // Changed from 8
                blurRadius: 2, // Changed from 1
                child: Container(width: 100, height: 50, color: Colors.blue),
              ),
            ),
          ),
        );

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
      },
    );
  });
}
