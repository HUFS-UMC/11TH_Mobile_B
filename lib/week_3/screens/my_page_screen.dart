import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../widgets/movie_bottom_navigation.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MovieBottomNavigation(currentIndex: 2),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              '내 프로필',
              style: TextStyle(
                color: AppColors.violet,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 54),
            Center(
              child: CircleAvatar(
                radius: 88,
                backgroundImage: const AssetImage(
                  'assets/images/profile/profile_movielog.jpg',
                ),
                backgroundColor: AppColors.lavender,
              ),
            ),
            const SizedBox(height: 22),
            const Center(
              child: Text(
                '무비러버',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '매주 주말에 영화관으로 출근하는 프로 관람객. 좋은 영화를 보고 기록하는 것을 좋아합니다.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, height: 1.6),
            ),
            const SizedBox(height: 26),
            Center(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('프로필 수정'),
              ),
            ),
            const SizedBox(height: 36),
            Row(
              children: const [
                Expanded(
                  child: _Stat(label: '본 영화', value: '342'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _Stat(label: '평점', value: '4.2'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _Stat(label: '즐겨찾기', value: '58'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              '선호하는 장르',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              children: ['드라마', 'SF', '애니메이션']
                  .map(
                    (genre) => Chip(
                      label: Text(genre),
                      backgroundColor: AppColors.lavender,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lavenderBorder),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(label),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.violet,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
