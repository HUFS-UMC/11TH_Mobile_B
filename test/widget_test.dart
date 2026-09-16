import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movielog/main.dart';

void main() {
  testWidgets('uses the new profile asset and Manrope app theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).theme?.fontFamily,
      'Manrope',
    );

    final profileImage = tester.widget<Image>(find.byType(Image));
    expect(
      (profileImage.image as AssetImage).assetName,
      'assets/images/profile/profile_movielog.jpg',
    );
  });
}
