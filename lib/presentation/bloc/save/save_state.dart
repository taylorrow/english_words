import 'package:equatable/equatable.dart';

abstract class SaveState extends Equatable {
  const SaveState();

  @override
  List<Object> get props => [];
}

class SaveDataStateSaving extends SaveState {}

class SaveDataStateSuccess extends SaveState {}

class SaveStateError extends SaveState {
  final String error;

  const SaveStateError(this.error);

  @override
  List<Object> get props => [error];
}
