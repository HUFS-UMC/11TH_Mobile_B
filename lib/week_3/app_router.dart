import 'package:go_router/go_router.dart';

import '../week_2/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/movie_detail_screen.dart';
import 'screens/movie_list_screen.dart';
import 'screens/my_page_screen.dart';
import 'screens/start_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, _) => const StartScreen()),
    GoRoute(path: '/signup', builder: (_, _) => const SignupScreen()),
    GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
    GoRoute(path: '/movies', builder: (_, _) => const MovieListScreen()),
    GoRoute(
      path: '/movies/:movieId',
      builder: (_, state) =>
          MovieDetailScreen(movieId: state.pathParameters['movieId']!),
    ),
    GoRoute(path: '/my', builder: (_, _) => const MyPageScreen()),
  ],
);
