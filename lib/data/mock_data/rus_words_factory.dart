class RussianWordsFactory {
  final List<String> rusWords = [
    'воздух',
    'животное',
    'ответ',
    'область',
    'птица',
    'тело',
    'книга',
    'низ',
    'мальчик',
    'брат',
    'лицо',
    'ребенок',
    'дети',
    'город',
    'класс',
    'цвет',
    'страна',
    'день',
    'собака',
    'дверь',
  ];

  List<String> get words => rusWords;

  List<String> wordsGen(int index) {
    List<String> forRandom = [];
    forRandom.addAll(rusWords);
    forRandom.removeAt(index);
    forRandom.shuffle();
    List<String> result = [];
    result.add(rusWords[index]);
    result.add(forRandom[0]);
    result.add(forRandom[1]);
    result.add(forRandom[2]);
    return result;
  }
}
