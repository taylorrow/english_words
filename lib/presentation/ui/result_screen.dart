import 'package:english_words/presentation/bloc/result/result_bloc.dart';
import 'package:english_words/presentation/bloc/result/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 70,
          ),
          _ResultField(),
          _HomeButton(),
        ],
      ),
    );
  }
}

class _ResultField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultBloc, ResultState>(
      bloc: BlocProvider.of<ResultBloc>(context),
      builder: (BuildContext context, ResultState state) {
        if (state is ResultStateStart) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ResultStateSuccess) {
          return Center(
            child: _ResultFieldPresenter(
              result: state.result,
              resultInfo: state.resultInfo,
            ),
          );
        }
        if (state is ResultStateError) {
          return Text(state.error);
        }
      },
    );
  }
}

class _ResultFieldPresenter extends StatelessWidget {
  final int result;
  final String resultInfo;

  const _ResultFieldPresenter({Key key, this.resultInfo, this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(resultInfo, style: Theme.of(context).textTheme.headline3),

        Text('${result.toString()}%',
            style: Theme.of(context).textTheme.headline2),
        // _InfoBloc()
      ],
    );
  }
}

class _HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FlatButton(
        textColor: Colors.white,
        color: Colors.lightBlue[800],
        minWidth: 300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          'В словарь',
        ),
      ),
    );
  }
}
