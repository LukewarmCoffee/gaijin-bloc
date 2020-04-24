import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../models/kado.dart';
import '../widgets.dart';

class VocabKadoItem extends StatefulWidget {
  final VocabKado kado;
  final Function previousPage;
  final Function nextPage;

  VocabKadoItem({
    @required this.kado,
    @required this.nextPage,
    @required this.previousPage,
  });

  @override
  _VocabKadoItemState createState() => _VocabKadoItemState();
}

class _VocabKadoItemState extends State<VocabKadoItem> {
  bool showAnswer = false;

  show() {
    setState(() {
      showAnswer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordsBloc, WordsState>(
      builder: (context, state) {
        if (state is WordsLoading) {
          return LoadingIndicator();
        } else if (state is WordsLoaded) {
          final word = state.words.firstWhere(
              (word) => word.id == widget.kado.wordId,
              orElse: () => null);
          return word.learned
              ? Container(
                  child: showAnswer
                      ? Column(children: <Widget>[
                          Text(word.japanese),
                          Text(word.kana),
                          Text(word.english),
                          Text(word.definition),
                          Row(
                            children: <Widget>[
                              RaisedButton(
                                child: Text('bad'),
                                onPressed: () {
                                  widget.nextPage();
                                  BlocProvider.of<WordsBloc>(context).add(
                                    UpdateWord(
                                      word.copyWith(
                                          confidence: word.confidence - 1.5),
                                    ),
                                  );
                                },
                              ),
                              RaisedButton(
                                child: Text('good'),
                                onPressed: () {
                                  widget.nextPage();
                                  BlocProvider.of<WordsBloc>(context).add(
                                    UpdateWord(
                                      word.copyWith(
                                          confidence: word.confidence + 1),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ])
                      : Column(children: <Widget>[
                          Text(word.japanese),
                          RaisedButton(
                            child: Text('show answer'),
                            onPressed: () => show(),
                          ),
                        ]),
                )
              : Column(
                  children: <Widget>[
                    Text(word.japanese),
                    Text(word.kana),
                    Text(word.english),
                    Text(word.definition),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          child: Text('prev'),
                          onPressed: () => widget.previousPage(),
                        ),
                        RaisedButton(
                          child: Text('next'),
                          onPressed: () {
                            widget.nextPage();
                            if (!word.learned)
                              BlocProvider.of<WordsBloc>(context).add(
                                UpdateWord(
                                  word.copyWith(learned: true),
                                ),
                              );
                          },
                        ),
                      ],
                    ),
                  ],
                );
        } else {
          return Container();
        }
      },
    );
  }
}
