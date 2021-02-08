import 'package:english_words/data/model/item_model.dart';
import 'package:equatable/equatable.dart';

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

class TestLoadDataStateLoading extends TestState {}

class TestLoadDataStateSuccess extends TestState {
  final List<MPItemModel> items;

  const TestLoadDataStateSuccess(this.items);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'TestLoadDataStateSuccess { items: ${items.length} }';
}

class TestStateError extends TestState {
  final String error;

  const TestStateError(this.error);

  @override
  List<Object> get props => [error];
}
