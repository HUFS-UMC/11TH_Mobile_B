import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../data/mock_movies.dart';
import '../widgets/movie_bottom_navigation.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = mockMovies.first;
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(currentIndex: 0),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'MovieLog',
                  style: TextStyle(
                    color: AppColors.violet,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search, size: 32),
                  tooltip: '검색',
                ),
              ],
            ),
            const SizedBox(height: 48),
            const Text(
              '오늘은 어떤\n영화를 볼까요?',
              style: TextStyle(
                fontSize: 40,
                height: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 28),
            _FeaturedMovie(movie: featured),
            const SizedBox(height: 36),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '인기 영화',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800),
                ),
                TextButton(
                  onPressed: () => context.go('/movies'),
                  child: const Text('전체보기  ›'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 230,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: mockMovies.skip(1).take(4).length,
                separatorBuilder: (_, _) => const SizedBox(width: 14),
                itemBuilder: (context, index) => SizedBox(
                  width: 135,
                  child: MovieCard(movie: mockMovies[index + 1]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedMovie extends StatelessWidget {
  const _FeaturedMovie({required this.movie});
  final dynamic movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/movies/${movie.id}'),
      child: AspectRatio(
        aspectRatio: .72,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(movie.posterAssetPath, fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Chip(
                      label: Text('추천 신작'),
                      backgroundColor: AppColors.violet,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '로맨스 · ${movie.genre} · ${movie.duration}분',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () => context.push('/movies/${movie.id}'),
                        icon: const Icon(Icons.info),
                        label: const Text('상세보기'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.violet,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
