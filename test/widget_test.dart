import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pawsome/screens/image_view.dart';


void main() {
  testWidgets("Zoom screen widget test", (WidgetTester tester) async {
    await tester.pumpWidget(
      const ImageViewScreen(path: "assets/images/Angel.jpg"),
    );
    final centerFinder = find.byType(Center);
    expect(centerFinder, findsOneWidget);
  });
}
