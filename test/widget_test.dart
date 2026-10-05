import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movielog/main.dart';

void main() {
  testWidgets('shows all required signup fields and agreement control', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(
      tester
          .widget<MaterialApp>(find.byType(MaterialApp))
          .theme
          ?.textTheme
          .bodyMedium
          ?.fontFamily,
      'Manrope',
    );
    expect(find.text('회원가입'), findsOneWidget);
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.byType(Checkbox), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, '가입하기'), findsOneWidget);
  });

  testWidgets('enables signup after all three inputs become valid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final fields = find.byType(TextFormField);
    final signupButton = find.widgetWithText(ElevatedButton, '가입하기');

    expect(tester.widget<ElevatedButton>(signupButton).onPressed, isNull);

    await tester.enterText(fields.at(0), '무비러버');
    await tester.enterText(fields.at(1), 'movie@example.com');
    await tester.enterText(fields.at(2), 'password1234');
    await tester.pump();

    expect(tester.widget<ElevatedButton>(signupButton).onPressed, isNotNull);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(tester.widget<ElevatedButton>(signupButton).onPressed, isNull);
  });

  testWidgets('keeps the signup button inside a phone-height viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(430, 1080);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    final signupButton = find.widgetWithText(ElevatedButton, '가입하기');
    expect(tester.getBottomRight(signupButton).dy, lessThanOrEqualTo(1080));
  });

  testWidgets('centers an appbar-free signup form on wide screens', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    expect(find.byType(AppBar), findsNothing);
    expect(find.text('MovieLog에 오신 것을 환영합니다!'), findsOneWidget);
    expect(tester.getSize(find.byType(Form)).width, 560);
  });
}
