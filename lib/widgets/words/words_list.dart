import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/pages.dart';
import '../../bloc/bloc.dart';
import '../widgets.dart';

class WordsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordsBloc, WordsState>(
      builder: (context, state) {
        if (state is WordsLoading) {
          return LoadingIndicator();
        } else if (state is WordsLoaded) {
          final words = state.words;
          return ListView.builder(
            itemCount: words.length,
            itemBuilder: (BuildContext context, int index) {
              final word = words[index];
              return WordItem(
                word: word,
                onDismissed: (direction) {
                  BlocProvider.of<WordsBloc>(context)
                      .add(DeleteWord(word));
                },
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return WordDetailsPage(id: word.id);
                    }),
                  );
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
