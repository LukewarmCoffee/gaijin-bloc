import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../models/kado.dart';
import '../widgets.dart';

class VocabKadoItem extends StatelessWidget {
  final VocabKado kado;

  VocabKadoItem({
    @required this.kado,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordsBloc, WordsState>(
      builder: (context, state) {
        if (state is WordsLoading) {
          return LoadingIndicator();
        } else if (state is WordsLoaded) {
          final word = state.words
              .firstWhere((word) => word.id == kado.wordId, orElse: () => null);
          return kado.learned
              ? Container(
                  child: Column(
                    children: <Widget>[
                      Text(word.japanese),
                      RaisedButton(
                        child: Text('good'),
                        onPressed: () {
                          BlocProvider.of<WordsBloc>(context).add(
                            UpdateWord(
                              word.copyWith(confidence: word.confidence + 1.0),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                )
              : ListTile(
                  title: Hero(
                    tag: '${kado.id}__heroTag',
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        word.japanese,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                );
        } else {
          return Container();
        }
      },
    );
  }
}
