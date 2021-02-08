import 'package:equatable/equatable.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();

  @override
  List<Object> get props => [];
}

class StartTest extends TestEvent {}
