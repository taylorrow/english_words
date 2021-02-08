import 'package:english_words/data/model/item_model.dart';
import 'package:english_words/presentation/bloc/dictionary/en_words_bloc.dart';
import 'package:english_words/presentation/bloc/dictionary/en_words_event.dart';
import 'package:english_words/presentation/bloc/dictionary/en_words_state.dart';
import 'package:english_words/presentation/bloc/test/test_bloc.dart';
import 'package:english_words/presentation/bloc/test/test_event.dart';
import 'package:english_words/presentation/ui/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryPage extends StatefulWidget {
  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  EnWordsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<EnWordsBloc>(context);
    _bloc.add(FetchMainData());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      _ListBody(),
      Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: _StartLessonButton(),
      ),
    ]);
  }
}

class _ListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EnWordsBloc, EnWordsState>(
      bloc: BlocProvider.of<EnWordsBloc>(context),
      builder: (BuildContext context, EnWordsState state) {
        if (state is LoadMainDataStateLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is LoadMainDataStateSuccess) {
          return state.items.isEmpty
              ? Text('No Results')
              : Expanded(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _ChatList(items: state.items),
                ));
        }
        if (state is LoadDataStateError) {
          return Text(state.error);
        }
      },
    );
  }
}

class _ChatList extends StatelessWidget {
  final List<MPItemModel> items;

  const _ChatList({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _ChatListItem(
          item: items[index],
        );
      },
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final MPItemModel item;

  const _ChatListItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: item.backgroundColor == 0
          ? Colors.white
          : item.backgroundColor == 1
              ? Colors.green
              : Colors.red,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              item.image,
              height: 40,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(item.word, style: Theme.of(context).textTheme.headline6),
                  Icon(Icons.volume_up),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartLessonButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Colors.white,
      color: Colors.lightBlue[800],
      minWidth: 300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      onPressed: () {
        BlocProvider.of<TestBloc>(context).add(StartTest());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => TestPage()),
        ).then(
            (_) => BlocProvider.of<EnWordsBloc>(context).add(UpdateMainData()));
      },
      child: Text(
        'Начать урок',
      ),
    );
  }
}
