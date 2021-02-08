import 'package:bloc/bloc.dart';
import 'package:english_words/data/repository/sembast_repo/sembast_reposirory.dart';
import 'package:english_words/presentation/bloc/save/save_event.dart';
import 'package:english_words/presentation/bloc/save/save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  final SembastRepository sembastRepository;

  SaveBloc({this.sembastRepository});

  @override
  void onTransition(Transition<SaveEvent, SaveState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  SaveState get initialState => SaveDataStateSaving();

  @override
  Stream<SaveState> mapEventToState(SaveEvent event) async* {
    if (event is SaveEvent) {
      yield SaveDataStateSaving();
      final model = event.model;
      try {
        await sembastRepository.update(model);
        yield SaveDataStateSuccess();
      } catch (error) {
        print(error);
      }
    }
  }
}
