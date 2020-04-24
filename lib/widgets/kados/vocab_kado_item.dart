import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import '../../models/kado.dart';
import '../widgets.dart';

class VocabKadoItem extends StatelessWidget {
  final VocabKado kado;
  final Function previousPage;
  final Function nextPage;

  VocabKadoItem({
    @required this.kado,
    @required this.nextPage,
    @required this.previousPage,
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
          return Column(
            children: <Widget>[
              kado.learned
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
                    ),
                    Row(
          children: <Widget>[
            RaisedButton(
              child: Text('prev'),
              onPressed: () => previousPage(),
            ),
            RaisedButton(
              child: Text('next'),
              onPressed: () => nextPage(),
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
