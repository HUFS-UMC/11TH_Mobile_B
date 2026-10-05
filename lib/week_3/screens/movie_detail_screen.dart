import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_colors.dart';
import '../data/mock_movies.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieId});
  final String movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool _isFavorite = false;
  double? _myRating;

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_isFavorite ? '즐겨찾기에 추가했습니다.' : '즐겨찾기에서 삭제했습니다.')),
    );
  }

  Future<void> _showRatingDialog() async {
    final rating = await showDialog<double>(
      context: context,
      builder: (_) => MovieRatingInput(initialRating: _myRating ?? 0),
    );
    if (rating != null) setState(() => _myRating = rating);
  }

  @override
  Widget build(BuildContext context) {
    final movie = findMovieById(widget.movieId);
    if (movie == null) {
      return const Scaffold(body: Center(child: Text('영화를 찾을 수 없습니다.')));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Cinema Archive',
          style: TextStyle(
            color: AppColors.violet,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    _isFavorite ? Icons.bookmark : Icons.bookmark_outline,
                  ),
                  label: Text(_isFavorite ? '즐겨찾기됨' : '즐겨찾기'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showRatingDialog,
                  icon: const Icon(Icons.rate_review_outlined),
                  label: Text(
                    _myRating == null
                        ? '평점 남기기'
                        : '내 평점 ${_myRating!.toStringAsFixed(1)}',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.violet,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: .92,
            child: Image.asset(movie.posterAssetPath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: _MovieInfo(movie: movie),
          ),
        ],
      ),
    );
  }
}

class _MovieInfo extends StatelessWidget {
  const _MovieInfo({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movie.title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text('${movie.year} · ${movie.genre} · ${movie.duration}분'),
        const SizedBox(height: 14),
        Row(
          children: [
            RatingBarIndicator(
              rating: movie.rating,
              itemBuilder: (_, _) =>
                  const Icon(Icons.star, color: AppColors.violet),
              itemCount: 5,
              itemSize: 26,
            ),
            const SizedBox(width: 8),
            Text(
              '${movie.rating} (1,245)',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          children: [
            movie.genre,
            '감동적인',
            '추천 신작',
          ].map((label) => Chip(label: Text(label))).toList(),
        ),
        const Divider(height: 48),
        const Text(
          '시놉시스',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 14),
        Text(movie.synopsis, style: const TextStyle(fontSize: 17, height: 1.8)),
        const SizedBox(height: 20),
        Text(
          '이 영화는 서로의 일상에 작은 빛이 되어 주는 순간을 담았습니다. 잔잔한 감정선과 따뜻한 영상미를 천천히 즐겨 보세요.',
          style: const TextStyle(fontSize: 17, height: 1.8),
        ),
      ],
    );
  }
}

class MovieRatingInput extends StatefulWidget {
  const MovieRatingInput({super.key, required this.initialRating});
  final double initialRating;

  @override
  State<MovieRatingInput> createState() => _MovieRatingInputState();
}

class _MovieRatingInputState extends State<MovieRatingInput> {
  late double _rating = widget.initialRating;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('평점 남기기'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _rating == 0
                ? '별을 눌러 평점을 선택하세요.'
                : '${_rating.toStringAsFixed(1)}점',
          ),
          const SizedBox(height: 16),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            allowHalfRating: true,
            itemBuilder: (_, _) =>
                const Icon(Icons.star, color: AppColors.violet),
            onRatingUpdate: (value) => setState(() => _rating = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: _rating == 0
              ? null
              : () => Navigator.pop(context, _rating),
          child: const Text('저장'),
        ),
      ],
    );
  }
}
