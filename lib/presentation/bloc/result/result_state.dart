import 'package:equatable/equatable.dart';

abstract class ResultState extends Equatable {
  const ResultState();

  @override
  List<Object> get props => [];
}

class ResultStateStart extends ResultState {}

class ResultStateSuccess extends ResultState {
  final int result;
  final String resultInfo;

  const ResultStateSuccess(this.result, this.resultInfo);

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'ResultStateSuccess { result: $result  resultInfo: $resultInfo }';
}

class ResultStateError extends ResultState {
  final String error;

  const ResultStateError(this.error);

  @override
  List<Object> get props => [error];
}
