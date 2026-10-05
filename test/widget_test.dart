import 'package:flutter_test/flutter_test.dart';

import 'package:movielog/main.dart';
import 'package:movielog/week_3/data/mock_movies.dart';

void main() {
  test('findMovieById returns the matching mock movie', () {
    expect(findMovieById('starlight')?.title, '별빛 아래 우리');
    expect(findMovieById('missing'), isNull);
  });

  testWidgets('starts on welcome screen and opens the signup route', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('시작하기'), findsOneWidget);
    await tester.tap(find.text('시작하기'));
    await tester.pumpAndSettle();
    expect(find.text('회원가입'), findsOneWidget);
  });
}
