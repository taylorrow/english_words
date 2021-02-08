import 'package:equatable/equatable.dart';

class ResultEvent extends Equatable {
  final int result;

  const ResultEvent({this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'ResultEvent { result: $result }';
}
