import 'package:e_commerce_app/core/utils/debouncer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('runs only the last action after the delay', (tester) async {
    var calls = 0;
    final debouncer = Debouncer(delay: const Duration(milliseconds: 100));

    debouncer
      ..run(() => calls += 1)
      ..run(() => calls += 10);
    await tester.pump(const Duration(milliseconds: 150));

    expect(calls, 10);
    debouncer.dispose();
  });

  testWidgets('cancel prevents the pending action', (tester) async {
    var called = false;
    final debouncer = Debouncer(delay: const Duration(milliseconds: 100))
      ..run(() => called = true)
      ..cancel();

    await tester.pump(const Duration(milliseconds: 150));

    expect(called, isFalse);
    debouncer.dispose();
  });
}
