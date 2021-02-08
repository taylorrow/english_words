import 'package:english_words/data/mock_data/en_words_factory.dart';
import 'package:english_words/data/mock_data/mapper/base_mapper.dart';
import 'package:english_words/data/model/item_model.dart';

class ItemMapper extends BaseMapper {
  final EnglishWordsFactory _englishWords = EnglishWordsFactory();
  List<String> _wordsList;

  @override
  List<MPItemModel> mapWordsToItem({int index}) {
    _wordsList = _englishWords.words;
    final items = _wordsList
        .map((e) => MPItemModel(
            image: 'assets/circle_face.png',
            word: e,
            backgroundColor: 0))
        .toList();
    return items;
  }
}
