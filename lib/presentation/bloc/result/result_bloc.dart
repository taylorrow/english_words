import 'package:bloc/bloc.dart';
import 'package:english_words/data/mock_data/rating.dart';
import 'package:english_words/data/repository/sembast_repo/sembast_reposirory.dart';
import 'package:english_words/presentation/bloc/save/save_event.dart';
import 'package:english_words/presentation/bloc/save/save_state.dart';

import 'result_event.dart';
import 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final Rating rating;

  ResultBloc({this.rating});

  @override
  void onTransition(Transition<ResultEvent, ResultState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  ResultState get initialState => ResultStateStart();

  @override
  Stream<ResultState> mapEventToState(ResultEvent event) async* {
    if (event is ResultEvent) {
      yield ResultStateStart();
      try {
        final result = event.result;
        final resultInfo = rating.getRating(result);
        yield ResultStateSuccess(result, resultInfo);
      } catch (error) {
        print(error);
      }
    }
  }
}
