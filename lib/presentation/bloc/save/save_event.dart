import 'package:english_words/data/model/item_model.dart';
import 'package:equatable/equatable.dart';

class SaveEvent extends Equatable {
  final MPItemModel model;

  const SaveEvent({this.model});

  @override
  List<Object> get props => [model];

  @override
  String toString() => 'SaveResult { word: ${model.word}  id: ${model.id} }';
}
