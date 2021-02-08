import 'package:english_words/data/model/four_rus_words.dart';
import 'package:english_words/data/model/item_model.dart';
import 'package:english_words/data/repository/mock_repo/mock_repository.dart';
import 'package:flutter/foundation.dart';

class TestProvider with ChangeNotifier {
  final MockRepository mockRepository;

  TestProvider({this.mockRepository});

  List<FourRusWordsModel> _rusWordsList;
  List<MPItemModel> enWordsList;

  int _wordsCount = 0;
  int _attempts = 0;
  String _correctAnswer;
  String _enWord;

  int get wordsCount => _wordsCount;

  int get attempts => _attempts;

  String get correctAnswer => _correctAnswer ?? '';

  String get enWord => _enWord ?? '';

  List get rusWordsList => _rusWordsList ?? [];

  void initTest(List<MPItemModel> list) {
    _wordsCount = 0;
    _attempts = 0;
    enWordsList = [];
    enWordsList.addAll(list);
  }

  void startTest() {
    _rusWordsList = [];
    _getRusWords(enWordsList[_wordsCount].id - 1);
    _enWord = enWordsList[_wordsCount].word;
  }

  void testCounter() {
    _wordsCount++;
    notifyListeners();
  }

  void _getRusWords(int id) {
    _rusWordsList.addAll(mockRepository.genRusWordsItems(id));
    _correctAnswer = _rusWordsList[0].word;
    _rusWordsList.shuffle();
  }

  void checkAnswer(String word, int index) {
    if (_correctAnswer != word) {
      _rusWordsList[_correctAnswerPosition()].borderColor = 1;
      _rusWordsList[index].borderColor = 2;
      _attempts++;
    } else {
      _rusWordsList[index].borderColor = 1;
    }
    notifyListeners();
  }

  int _correctAnswerPosition() {
    for (int i = 0; i < _rusWordsList.length; i++) {
      if (_rusWordsList[i].word == _correctAnswer) {
        return i;
      }
    }
  }
}
