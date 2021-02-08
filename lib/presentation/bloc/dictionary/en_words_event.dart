import 'package:equatable/equatable.dart';

abstract class EnWordsEvent extends Equatable {
  const EnWordsEvent();

  @override
  List<Object> get props => [];
}

class FetchMainData extends EnWordsEvent {}

class UpdateMainData extends EnWordsEvent {}
