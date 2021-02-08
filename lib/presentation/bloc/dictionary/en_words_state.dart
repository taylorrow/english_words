import 'package:english_words/data/model/item_model.dart';
import 'package:equatable/equatable.dart';

abstract class EnWordsState extends Equatable {
  const EnWordsState();

  @override
  List<Object> get props => [];
}

class LoadMainDataStateLoading extends EnWordsState {}

class LoadMainDataStateSuccess extends EnWordsState {
  final List<MPItemModel> items;

  const LoadMainDataStateSuccess(this.items);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'LoadMainDataStateSuccess { items: ${items.length} }';
}

class LoadDataStateError extends EnWordsState {
  final String error;

  const LoadDataStateError(this.error);

  @override
  List<Object> get props => [error];
}
