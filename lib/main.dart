import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'week_3/app_router.dart';

// 앱 실행 진입점: 연습 코드를 실행한 뒤 앱을 시작한다.
void main() {
  runDartPractice();
  runApp(const MyApp());
}

class Movie {
  const Movie({required this.id, required this.title});

  final int id;
  final String title;
}

// Null Safety: 닉네임이 없거나 비어 있으면 기본값을 사용한다.
String displayName(String? nickname) {
  return nickname?.trim().isNotEmpty == true ? nickname! : '이름 없음';
}

void runDartPractice() {
  // List에 Movie 객체 3개를 저장한다.
  final movies = <Movie>[
    const Movie(id: 1, title: '인셉션'),
    const Movie(id: 2, title: '인터스텔라'),
    const Movie(id: 3, title: '토이 스토리'),
  ];

  // for문으로 영화 제목을 출력한다.
  for (final movie in movies) {
    debugPrint(movie.title);
  }

  debugPrint(displayName(null));
  debugPrint(displayName('무비러버'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // StatelessWidget: 상태가 변하지 않는 앱 설정 화면이다.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MovieLog',
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
