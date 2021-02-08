import 'package:english_words/data/mock_data/mapper/item_mapper.dart';
import 'package:english_words/data/mock_data/mapper/rus_item_mapper.dart';
import 'package:english_words/data/mock_data/rus_words_factory.dart';
import 'package:english_words/data/model/four_rus_words.dart';
import 'package:english_words/data/model/item_model.dart';

import 'mock_base_repository.dart';

class MockRepository extends MockBaseRepository {
  final ItemMapper _itemMapper = ItemMapper();
  final RusItemMapper _rusItemMapper = RusItemMapper();
  final RussianWordsFactory _rusFactory = RussianWordsFactory();

  @override
  List<MPItemModel> getEnWordsItems() {
    return _itemMapper.mapWordsToItem();
  }

  @override
  List<String> getRusWordsList() {
    return _rusFactory.words;
  }

  @override
  List<FourRusWordsModel> genRusWordsItems(int id) {
    return _rusItemMapper.mapWordsToItem(index: id);
  }
}
