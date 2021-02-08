import 'package:bloc/bloc.dart';
import 'package:english_words/data/repository/mock_repo/mock_repository.dart';
import 'package:english_words/data/repository/sembast_repo/sembast_reposirory.dart';

import 'en_words_event.dart';
import 'en_words_state.dart';

class EnWordsBloc extends Bloc<EnWordsEvent, EnWordsState> {
  final MockRepository mockRepository;
  final SembastRepository sembastRepository;

  EnWordsBloc({this.sembastRepository, this.mockRepository});

  @override
  void onTransition(Transition<EnWordsEvent, EnWordsState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  EnWordsState get initialState => LoadMainDataStateLoading();

  @override
  Stream<EnWordsState> mapEventToState(EnWordsEvent event) async* {
    if (event is FetchMainData) {
      yield LoadMainDataStateLoading();
      try {
        await sembastRepository.deleteAll();
        final resultsListFromClient = mockRepository.getEnWordsItems();
        await sembastRepository.insertAll(resultsListFromClient);
        final resultsListFromDB = await sembastRepository.readAll();
        yield LoadMainDataStateSuccess(resultsListFromDB);
      } catch (error) {
        yield LoadDataStateError('something went wrong');
      }
    }
    if (event is UpdateMainData) {
      yield LoadMainDataStateLoading();
      try {
        final resultsListFromDB = await sembastRepository.readAll();
        yield LoadMainDataStateSuccess(resultsListFromDB);
      } catch (error) {
        yield LoadDataStateError('something went wrong');
      }
    }
  }
}
