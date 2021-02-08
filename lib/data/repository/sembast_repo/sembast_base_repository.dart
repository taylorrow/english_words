import 'package:english_words/data/model/item_model.dart';

abstract class SembastBaseRepository {
  Future<int> insert(MPItemModel model);

  Future insertAll(List<MPItemModel> list);

  Future update(MPItemModel model);

  Future delete(int id);

  Future<List<MPItemModel>> readAll();

  Future<MPItemModel> read(int id);

  Future<MPItemModel> readByKey(MPItemModel model);

  Future deleteAll();
}
