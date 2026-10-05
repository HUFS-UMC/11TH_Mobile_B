import '../models/movie.dart';

const mockMovies = <Movie>[
  Movie(
    id: 'starlight',
    title: '별빛 아래 우리',
    genre: '드라마',
    year: 2024,
    duration: 124,
    posterAssetPath: 'assets/images/posters/hero_under_the_starlight.jpg',
    rating: 4.5,
    synopsis: '바쁜 일상 속에서 만난 두 사람이 별을 보며 서로의 상처를 이해하고, 작은 용기를 찾아가는 로맨스 드라마입니다.',
  ),
  Movie(
    id: 'echoes',
    title: '우주의 끝에서',
    genre: 'SF',
    year: 2024,
    duration: 118,
    posterAssetPath: 'assets/images/posters/poster_echoes_of_the_void.jpg',
    rating: 4.2,
    synopsis: '미지의 행성에 남겨진 탐사대가 고향으로 돌아가기 위해 신호의 비밀을 풀어 갑니다.',
  ),
  Movie(
    id: 'whispering-woods',
    title: '속삭이는 숲',
    genre: '애니메이션',
    year: 2023,
    duration: 102,
    posterAssetPath: 'assets/images/posters/poster_whispering_woods.jpg',
    rating: 4.9,
    synopsis: '말을 잃은 숲의 정령과 아이가 함께 떠나는 따뜻한 판타지 모험입니다.',
  ),
  Movie(
    id: 'night-shadows',
    title: '밤의 그림자',
    genre: '스릴러',
    year: 2024,
    duration: 109,
    posterAssetPath: 'assets/images/posters/poster_night_shadows.jpg',
    rating: 3.8,
    synopsis: '비가 내리는 도시의 골목에서 시작된 사건을 추적하는 미스터리 스릴러입니다.',
  ),
  Movie(
    id: 'abyss-walker',
    title: '심연의 방랑자',
    genre: 'SF',
    year: 2023,
    duration: 131,
    posterAssetPath: 'assets/images/posters/poster_abyss_walker.jpg',
    rating: 4.1,
    synopsis: '깊은 바다 아래 발견된 낯선 세계를 탐험하는 잠수사의 이야기입니다.',
  ),
  Movie(
    id: 'fourth-afternoon',
    title: '네 번째 오후',
    genre: '드라마',
    year: 2022,
    duration: 96,
    posterAssetPath: 'assets/images/posters/poster_fourth_afternoon.jpg',
    rating: 4.0,
    synopsis: '매주 같은 카페에서 마주치는 두 사람의 조용한 우정을 담은 영화입니다.',
  ),
];

Movie? findMovieById(String id) {
  for (final movie in mockMovies) {
    if (movie.id == id) return movie;
  }
  return null;
}
