import 'dart:async';

import 'package:english_words/data/model/four_rus_words.dart';
import 'package:english_words/data/model/item_model.dart';
import 'package:english_words/presentation/bloc/result/result_bloc.dart';
import 'package:english_words/presentation/bloc/result/result_event.dart';
import 'package:english_words/presentation/bloc/save/save_bloc.dart';
import 'package:english_words/presentation/bloc/save/save_event.dart';
import 'package:english_words/presentation/bloc/test/test_bloc.dart';
import 'package:english_words/presentation/bloc/test/test_state.dart';
import 'package:english_words/presentation/provider/test_provider.dart';
import 'package:english_words/presentation/ui/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Найди слово'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[_WordsField(), _InfoBloc()],
      ),
    );
  }
}

class _Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _WordsField(),
        // _InfoBloc()
      ],
    );
  }
}

class _WordsField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(
      bloc: BlocProvider.of<TestBloc>(context),
      builder: (BuildContext context, TestState state) {
        if (state is TestLoadDataStateLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is TestLoadDataStateSuccess) {
          if (state.items.isNotEmpty) {
            context.read<TestProvider>().initTest(state.items);
            context.read<TestProvider>().startTest();
          }
          return state.items.isEmpty
              ? Text('No Results')
              : _WordsPresenter(
                  enWordModelList: state.items,
                );
        }
        if (state is TestStateError) {
          return Text(state.error);
        }
      },
    );
  }
}

class _WordsPresenter extends StatelessWidget {
  const _WordsPresenter({Key key, this.enWordModelList}) : super(key: key);

  final List<MPItemModel> enWordModelList;

  @override
  Widget build(BuildContext context) {
    int _enWordsCounter = context.watch<TestProvider>().wordsCount;
    String _enWord = context.watch<TestProvider>().enWord;
    List<FourRusWordsModel> _rusWordsList =
        context.watch<TestProvider>().rusWordsList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          width: 150,
          child: Card(child: Center(child: Text(_enWord))),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: _rusWordsList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _RusWordItem(
                  item: _rusWordsList[index],
                  index: index,
                  enWordModel: enWordModelList[_enWordsCounter],
                );
              }),
        ),
      ],
    );
  }
}

class _RusWordItem extends StatelessWidget {
  final FourRusWordsModel item;
  final int index;
  final MPItemModel enWordModel;

  const _RusWordItem(
      {Key key, @required this.item, this.index, this.enWordModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<TestBloc, TestState>(
      listener: (context, state) {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(
                width: 3,
                color: item.borderColor == 0
                    ? Colors.transparent
                    : item.borderColor == 1
                        ? Colors.green
                        : Colors.red)),
        child: Card(
          child: InkResponse(
            enableFeedback: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  item.image,
                ),
                Text(item.word),
              ],
            ),
            onTap: () {
              context.read<TestProvider>().checkAnswer(item.word, index);

              _editWordModel(context);

              int _wordsCounter = 5 - (context.read<TestProvider>().wordsCount);
              int _attempts = 2 - (context.read<TestProvider>().attempts);
              Timer(
                  const Duration(
                    milliseconds: 500,
                  ), () {
                if (_wordsCounter == 1 || _attempts == 0) {
                  BlocProvider.of<ResultBloc>(context).add(ResultEvent(
                      result: _resultGen(_wordsCounter, _attempts)));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Result()),
                  );
                  return;
                }
                context.read<TestProvider>().testCounter();
                context.read<TestProvider>().startTest();
              });
            },
          ),
        ),
      ),
    );
  }

  int _resultGen(int words, int attempts) {
    return (6 - words) * 20 - (2 - attempts) * 20;
  }

  void _editWordModel(context) {
    final updatedModel =
        enWordModel.copyWith(backgroundColor: item.borderColor);
    BlocProvider.of<SaveBloc>(context).add(SaveEvent(model: updatedModel));
  }
}

class _InfoBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _wordsCount = 5 - (context.watch<TestProvider>().wordsCount);
    int _attempts = 2 - (context.watch<TestProvider>().attempts);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text('Слов для изучения: ${_wordsCount.toString()}'),
        SizedBox(
          height: 10,
        ),
        Text('Попыток: ${_attempts.toString()}'),
      ],
    );
  }
}
