import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'data/mock_data/rating.dart';
import 'data/repository/mock_repo/mock_repository.dart';
import 'data/repository/sembast_repo/sembast_reposirory.dart';
import 'data/sembast/init.dart';
import 'presentation/bloc/dictionary/en_words_bloc.dart';
import 'presentation/bloc/result/result_bloc.dart';
import 'presentation/bloc/save/save_bloc.dart';
import 'presentation/bloc/test/test_bloc.dart';
import 'presentation/provider/test_provider.dart';
import 'presentation/ui/dictionary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Init.initialize();
  final MockRepository mockRepository = MockRepository();
  final SembastRepository sembastRepository = SembastRepository();
  final Rating rating = Rating();
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider<EnWordsBloc>(
            create: (BuildContext context) => EnWordsBloc(
                mockRepository: mockRepository,
                sembastRepository: sembastRepository),
          ),
          BlocProvider<TestBloc>(
            create: (BuildContext context) =>
                TestBloc(sembastRepository: sembastRepository),
          ),
          BlocProvider<SaveBloc>(
            create: (BuildContext context) =>
                SaveBloc(sembastRepository: sembastRepository),
          ),
          BlocProvider<ResultBloc>(
            create: (BuildContext context) => ResultBloc(rating: rating),
          ),
        ],
        child: MultiProvider(providers: [
          ChangeNotifierProvider(
              create: (_) => TestProvider(mockRepository: mockRepository)),
        ], child: MyApp())),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Словарь'),
            centerTitle: true,
          ),
          body: DictionaryPage(),
        ));
  }
}
