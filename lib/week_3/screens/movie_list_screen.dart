import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../data/mock_movies.dart';
import '../models/movie.dart';
import '../widgets/movie_bottom_navigation.dart';
import '../widgets/movie_card.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  String _selectedGenre = '전체';
  final _genres = const ['전체', '드라마', 'SF', '애니메이션', '스릴러'];

  List<Movie> get _movies => _selectedGenre == '전체'
      ? mockMovies
      : mockMovies.where((movie) => movie.genre == _selectedGenre).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(currentIndex: 1),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            const Text(
              '영화',
              style: TextStyle(
                color: AppColors.violet,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 18),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _genres
                    .map(
                      (genre) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(genre),
                          selected: _selectedGenre == genre,
                          selectedColor: AppColors.violet,
                          labelStyle: TextStyle(
                            color: _selectedGenre == genre
                                ? Colors.white
                                : AppColors.black,
                          ),
                          onSelected: (_) =>
                              setState(() => _selectedGenre = genre),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .56,
                crossAxisSpacing: 16,
                mainAxisSpacing: 22,
              ),
              itemBuilder: (_, index) => MovieCard(movie: _movies[index]),
            ),
          ],
        ),
      ),
    );
  }
}
