import 'package:bloc/bloc.dart';
import 'package:english_words/data/repository/sembast_repo/sembast_reposirory.dart';
import 'package:english_words/presentation/bloc/test/test_event.dart';
import 'package:english_words/presentation/bloc/test/test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final SembastRepository sembastRepository;

  TestBloc({this.sembastRepository});

  @override
  void onTransition(Transition<TestEvent, TestState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  TestState get initialState => TestLoadDataStateLoading();

  @override
  Stream<TestState> mapEventToState(TestEvent event) async* {
    if (event is StartTest) {
      yield TestLoadDataStateLoading();
      try {
        final resultsListFromDB = await sembastRepository.fiveEnWordGen();
        yield TestLoadDataStateSuccess(resultsListFromDB);
      } catch (error) {
        yield TestStateError('something went wrong');
      }
    }
  }
}
