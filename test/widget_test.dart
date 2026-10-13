import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourist_app/app/app.dart';

void main() {
  testWidgets('KaribuApp smoke test loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: KaribuApp(),
      ),
    );

    // Initial pump
    await tester.pump();

    // Verify KaribuApp renders without errors
    expect(find.byType(KaribuApp), findsOneWidget);
  });

  testWidgets('SplashScreen animation and logo are centered in the viewport',
      (WidgetTester tester) async {
    // Set a typical phone viewport size
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: KaribuApp(),
      ),
    );
    await tester.pump();

    // Verify brand logo RichText exists
    final richTextFinder = find.byWidgetPredicate(
      (widget) => widget is RichText && widget.text.toPlainText().contains('karibu'),
    );
    expect(richTextFinder, findsOneWidget);

    // Verify center alignment
    final screenSize = tester.view.physicalSize / tester.view.devicePixelRatio;
    final screenCenter = Offset(screenSize.width / 2, screenSize.height / 2);

    final karibuCenter = tester.getCenter(richTextFinder);
    // Horizontally centered within a narrow margin
    expect((karibuCenter.dx - screenCenter.dx).abs(), lessThan(5.0));

    // Pump frames to ensure timer and animation controller complete smoothly
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 2200));
    await tester.pump();
  });
}
