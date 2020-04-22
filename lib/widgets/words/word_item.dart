import 'package:flutter/material.dart';
import 'package:gaijin_bloc/utils/utils.dart';

import '../../models/models.dart';

class WordItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Word word;

  WordItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.word,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Keys.wordItem(word.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Hero(
          tag: '${word.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              word.japanese,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        subtitle: 
             Text(
                word.english,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subhead,
              )
          
      ),
    );
  }
}