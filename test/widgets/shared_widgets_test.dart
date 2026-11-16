import 'package:e_commerce_app/app/theme/app_theme.dart';
import 'package:e_commerce_app/core/widgets/app_empty_view.dart';
import 'package:e_commerce_app/core/widgets/app_error_view.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/price_breakdown.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) {
  return MaterialApp(
    theme: AppTheme.light,
    home: Scaffold(body: Center(child: child)),
  );
}

void main() {
  group('QuantityStepper', () {
    testWidgets('increments until the maximum', (tester) async {
      var quantity = 1;
      await tester.pumpWidget(
        _wrap(
          StatefulBuilder(
            builder: (context, setState) => QuantityStepper(
              quantity: quantity,
              max: 2,
              onChanged: (value) => setState(() => quantity = value),
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add_rounded));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      final plus = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.add_rounded),
      );
      expect(plus.onPressed, isNull);
    });

    testWidgets('minus is disabled at the minimum', (tester) async {
      await tester.pumpWidget(
        _wrap(QuantityStepper(quantity: 1, onChanged: (_) {})),
      );

      final minus = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.remove_rounded),
      );
      expect(minus.onPressed, isNull);
    });
  });

  group('PriceBreakdown', () {
    testWidgets('hides the discount row and shows free shipping', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const PriceBreakdown(
            subtotal: 100,
            discount: 0,
            shipping: 0,
            total: 100,
          ),
        ),
      );

      expect(find.text('Free'), findsOneWidget);
      expect(find.text('Discount'), findsNothing);
      expect(find.text(r'$100.00'), findsNWidgets(2));
    });

    testWidgets('shows discount, shipping fee and total', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const PriceBreakdown(
            subtotal: 120,
            discount: 20,
            shipping: 4.99,
            total: 104.99,
          ),
        ),
      );

      expect(find.text('Discount'), findsOneWidget);
      expect(find.text(r'-$20.00'), findsOneWidget);
      expect(find.text(r'$4.99'), findsOneWidget);
      expect(find.text(r'$104.99'), findsOneWidget);
    });
  });

  group('Empty and error views', () {
    testWidgets('AppEmptyView shows its text and runs the action', (
      tester,
    ) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(
          AppEmptyView(
            icon: Icons.inbox_outlined,
            title: 'Nothing here',
            subtitle: 'Come back later',
            actionLabel: 'Go',
            onAction: () => tapped = true,
          ),
        ),
      );

      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('Come back later'), findsOneWidget);

      await tester.tap(find.text('Go'));
      expect(tapped, isTrue);
    });

    testWidgets('AppErrorView offers a retry', (tester) async {
      var retried = false;
      await tester.pumpWidget(
        _wrap(AppErrorView(message: 'Oops', onRetry: () => retried = true)),
      );

      expect(find.text('Oops'), findsOneWidget);

      await tester.tap(find.text('Try again'));
      expect(retried, isTrue);
    });
  });
}
