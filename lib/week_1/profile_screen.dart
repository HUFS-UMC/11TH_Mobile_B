import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'widgets/common_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 데이터만 바꿔 같은 StatItem을 재사용한다.
    final stats = [
      const StatItem(label: '본 영화', value: '342'),
      const StatItem(label: '평점', value: '4.2'),
      const StatItem(label: '즐겨찾기', value: '58'),
    ];
    final genres = ['드라마', 'SF', '애니메이션'];

    return Scaffold(
      // Scaffold: 한 화면의 기본 뼈대다.
      appBar: const CommonAppBar(title: '내 프로필'),
      body: SafeArea(
        child: SingleChildScrollView(
          // Padding은 화면 안쪽 여백이다.
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _ProfileHeader(),
              const SizedBox(height: 36),
              Center(
                child: SizedBox(
                  width: 180,
                  height: 56,
                  child: TextButton(
                    onPressed: () {
                      debugPrint('프로필 수정 버튼을 눌렀습니다.');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.violet,
                      side: const BorderSide(
                        color: AppColors.violet,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('프로필 수정'),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Row의 주축은 가로 방향이다.
              Row(
                children: stats
                    .map(
                      (stat) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: stat,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 40),
              Text(
                '선호하는 장르',
                style: AppTextStyles.titleMedium.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              // Wrap은 공간이 부족하면 다음 줄로 내려간다.
              Wrap(
                spacing: 12,
                children: genres
                    .map(
                      (genre) => Chip(
                        label: Text(genre),
                        backgroundColor: AppColors.lavender,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        labelStyle: const TextStyle(
                          color: AppColors.violet,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    // Column의 주축은 세로 방향이다.
    return Column(
      children: [
        Container(
          width: 176,
          height: 176,
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
              BorderSide(color: AppColors.violet, width: 1),
            ),
          ),
          child: ClipOval(
            // 로컬 비트맵 이미지를 Asset 경로로 불러온다.
            child: Image.asset(
              'assets/images/profile/profile_movielog.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          '무비러버',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Text(
          '매주 주말에 영화관으로 출근하는 프로 관람객.\n'
          '좋은 영화를 보고 기록하는 것을 좋아합니다.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: AppColors.black, height: 1.5),
        ),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  const StatItem({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    // Theme.of(context)에서 현재 앱 색상을 가져온다.
    final colors = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 118),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.warmWhite,
        border: Border.all(color: AppColors.lavenderBorder, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(label, style: AppTextStyles.bodyMedium.copyWith(fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              color: colors.primary,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
