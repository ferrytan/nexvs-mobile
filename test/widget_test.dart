import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nexvs/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NexvsApp());
    expect(find.text('NEXVS'), findsOneWidget);
    expect(find.text('Connect & VS'), findsOneWidget);
  });
}
