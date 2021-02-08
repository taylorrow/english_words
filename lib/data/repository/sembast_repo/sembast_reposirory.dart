import 'package:english_words/data/model/item_model.dart';
import 'package:get_it/get_it.dart';
import 'package:sembast/sembast.dart';

import 'sembast_base_repository.dart';

class SembastRepository extends SembastBaseRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store('words');

  @override
  Future deleteAll() async {
    await _store.delete(_database);
  }

  @override
  Future<MPItemModel> readByKey(MPItemModel model) async {
    var valueKey = await _store.record(model.word).getSnapshot(_database);
    var value = await _store.record(model.word).get(_database);
    int newKey = (int.parse(valueKey.key.toString())) % 20;
    if (newKey == 0) newKey = 20;
    return MPItemModel.fromMap(newKey, valueKey.key, value);
  }

  @override
  Future<MPItemModel> read(
    int id,
  ) async {
    final value = await _store.record(id).get(_database);
    final valueKey = await _store.record(id).getSnapshot(_database);
    return MPItemModel.fromMap(id, valueKey.key, value);

    // MPItemModel mpItemModel;
    // var value = await _store.record(model.word).get(_database);
    // mpItemModel = MPItemModel.fromMap(snapshot.key,value);
    // return mpItemModel;
  }

  @override
  Future delete(int id) async {
    await _store.record(id).delete(_database);

    // final finder = Finder(filter: Filter.byKey(model.word));
    // await _store.delete(_database, finder: finder);
  }

  @override
  Future<List<MPItemModel>> readAll() async {
    final recordSnapshot = await _store.find(_database);
    return recordSnapshot.map((snapshot) {
      int newKey = (int.parse(snapshot.key.toString())) % 20;
      if (newKey == 0) newKey = 20;
      return MPItemModel.fromMap(newKey, snapshot.key, snapshot.value);
    }).toList(growable: false);
  }

  @override
  Future insertAll(List<MPItemModel> list) async {
    for (int i = 0; i < list.length; i++) {
      await _store.add(_database, list[i].toMap());
    }
  }

  @override
  Future<int> insert(MPItemModel model) async {
    return await _store.add(_database, model.toMap());
  }

  @override
  Future update(MPItemModel model) async {
    await _store.record(model.realId).update(_database, model.toMap());

    // final finder = Finder(filter: Filter.byKey(model.word));
    // await _store.update(_database, model.toMap(), finder: finder);
  }

  Future<List<MPItemModel>> fiveEnWordGen() async {
    List<MPItemModel> resultWhite;
    List<MPItemModel> resultRed;
    List<MPItemModel> resultGreen;
    final list = await readAll();
    list.shuffle();
    resultWhite = _getWhiteWords(list);
    if (resultWhite.length >= 5) {
      return resultWhite.sublist(0, 5);
    } else {
      resultRed = _getRedWords(list);
      if ((resultWhite.length + resultRed.length) >= 5) {
        int length = 5 - resultWhite.length;
        resultWhite.addAll(resultRed.sublist(0, length));
        return resultWhite;
      } else {
        resultGreen = _getGreenWords(list);
        if ((resultWhite.length + resultRed.length + resultGreen.length) >= 5) {
          int length = 5 - resultWhite.length - resultRed.length;
          resultWhite.addAll(resultRed);
          resultWhite.addAll(resultGreen.sublist(0, length));
          return resultWhite;
        }
      }
    }
  }

  List<MPItemModel> _getWhiteWords(List<MPItemModel> list) {
    List<MPItemModel> result = [];
    list.forEach((element) {
      if (element.backgroundColor == 0) {
        result.add(element);
      }
    });
    return result;
  }

  List<MPItemModel> _getRedWords(List<MPItemModel> list) {
    List<MPItemModel> result = [];
    list.forEach((element) {
      if (element.backgroundColor == 2) {
        result.add(element);
      }
    });
    return result;
  }

  List<MPItemModel> _getGreenWords(List<MPItemModel> list) {
    List<MPItemModel> result = [];
    list.forEach((element) {
      if (element.backgroundColor == 1) {
        result.add(element);
      }
    });
    return result;
  }
}
