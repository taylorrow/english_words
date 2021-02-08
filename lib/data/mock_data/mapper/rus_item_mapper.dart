import 'package:english_words/data/mock_data/mapper/base_mapper.dart';
import 'package:english_words/data/mock_data/rus_words_factory.dart';
import 'package:english_words/data/model/four_rus_words.dart';

class RusItemMapper extends BaseMapper {
  final RussianWordsFactory _factory = RussianWordsFactory();
  List<String> _wordsList;

  @override
  List<FourRusWordsModel> mapWordsToItem({int index}) {
    _wordsList = _factory.wordsGen(index);
    final items = _wordsList
        .map((e) => FourRusWordsModel(
            word: e, image: 'assets/circle_face.png', borderColor: 0))
        .toList();
    return items;
  }
}
