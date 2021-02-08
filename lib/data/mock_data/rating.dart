class Rating {
  final String bad = 'Можете Лучше!';
  final String good = 'Поздравляем!';

  String getRating(int percent) {
    if (percent < 60) {
      return bad;
    } else {
      return good;
    }
  }
}
