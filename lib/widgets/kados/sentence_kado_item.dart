import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../models/models.dart';
import '../widgets.dart';

class SentenceKadoItem extends StatefulWidget {
  final SentenceKado kado;
  final Function previousPage;
  final Function nextPage;

  SentenceKadoItem({
    @required this.kado,
    @required this.nextPage,
    @required this.previousPage,
  });

  @override
  _SentenceKadoItemState createState() => _SentenceKadoItemState();
}

class _SentenceKadoItemState extends State<SentenceKadoItem> {
  bool kana = false;
  bool english = false;
  bool answer = false;
  Map<String, bool> good = Map();

  @override
  void initState() {
    for (String id in widget.kado.wordIds) good[id] = true;
    super.initState();
  }

  showKana() {
    setState(() {
      kana = true;
    });
  }

  showEnglish() {
    setState(() {
      english = true;
    });
  }

  showAnswer() {
    setState(() {
      answer = true;
    });
  }

  switchGood(String id) {
    setState(() {
      good[id] = !good[id];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordsBloc, WordsState>(
      builder: (context, state) {
        if (state is WordsLoading) {
          return LoadingIndicator();
        } else if (state is WordsLoaded) {
          final List<Word> words = widget.kado.wordIds
              .map((wordId) =>
                  state.words.firstWhere((word) => word.id == wordId))
              .toList();
          return answer
              ? Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        for (Word word in words)
                          GestureDetector(
                            child: good[word.id]
                                ? Container(
                                    child: Text(word.japanese),
                                    color: Colors.greenAccent,
                                  )
                                : Container(
                                    child: Text(word.japanese),
                                    color: Colors.redAccent,
                                  ),
                            onTap: () => switchGood(word.id),
                          )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        for (Word word in words) Text(word.kana)
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        for (Word word in words) Text(word.english + ' ')
                      ],
                    ),
                    Container(child: Text(widget.kado.translation ?? '')),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          child: Text('continue'),
                          onPressed: () {
                            widget.nextPage();
                            for (Word word in words)
                              if (!good[word.id])
                                BlocProvider.of<WordsBloc>(context).add(
                                  UpdateWord(
                                    word.copyWith(
                                        confidence: word.confidence - 0.75),
                                  ),
                                );
                              else if (good[word.id])
                                BlocProvider.of<WordsBloc>(context).add(
                                  UpdateWord(
                                    word.copyWith(
                                        confidence: word.confidence + 0.5),
                                  ),
                                );
                          },
                        ),
                        RaisedButton(
                          child: Text('good'),
                          onPressed: () {
                            widget.nextPage();
                            for (Word word in words)
                              BlocProvider.of<WordsBloc>(context).add(
                                UpdateWord(
                                  word.copyWith(
                                      confidence: word.confidence + 0.5),
                                ),
                              );
                          },
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        for (Word word in words) Text(word.japanese),
                      ],
                    ),
                    RaisedButton(
                      child: Text('show answer'),
                      onPressed: () => showAnswer(),
                    )
                  ],
                );
        } else {
          return Container();
        }
      },
    );
  }
}
