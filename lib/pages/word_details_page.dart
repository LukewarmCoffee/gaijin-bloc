import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/pages.dart';
import '../bloc/bloc.dart';

class WordDetailsPage extends StatelessWidget {
  final String id;

  WordDetailsPage({@required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordsBloc, WordsState>(
      builder: (context, state) {
        final word = (state as WordsLoaded)
            .words
            .firstWhere((word) => word.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Details..'),
            actions: [
              IconButton(
                tooltip: 'delete',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<WordsBloc>(context).add(DeleteWord(word));
                  Navigator.pop(context, word);
                },
              )
            ],
          ),
          body: word == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Hero(
                                  tag: '${word.id}__heroTag',
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 16.0,
                                    ),
                                    child: Text(
                                      word.japanese,
                                      style:
                                          Theme.of(context).textTheme.headline,
                                    ),
                                  ),
                                ),
                                Text(
                                  word.kana,
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                                Text(
                                  word.english,
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                                Text(
                                  word.definition == null
                                      ? ''
                                      : word.definition,
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                                Text(
                                  word.confidence.toStringAsFixed(2),
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'edit',
            child: Icon(Icons.edit),
            onPressed: word == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditWordPage(
                            onSave: (japanese, kana, english, definition) {
                              BlocProvider.of<WordsBloc>(context).add(
                                UpdateWord(
                                  word.copyWith(
                                    japanese: japanese,
                                    kana: kana,
                                    english: english,
                                    definition: definition,
                                  ),
                                ),
                              );
                            },
                            isEditing: true,
                            word: word,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}
