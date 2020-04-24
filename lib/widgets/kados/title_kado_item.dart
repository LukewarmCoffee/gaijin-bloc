import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/kado.dart';

class TitleKadoItem extends StatelessWidget {
  final TitleKado kado;
  final Function nextPage;
  final Function previousPage;

  TitleKadoItem({
    @required this.kado,
    @required this.nextPage,
    @required this.previousPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: kado.title.isNotEmpty
              ? Hero(
                  tag: '${kado.id}__heroTag',
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      kado.title,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                )
              : null,
          subtitle: kado.subtitle.isNotEmpty
              ? Text(
                  kado.subtitle,
                  style: Theme.of(context).textTheme.subhead,
                )
              : null,
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
  }
}
