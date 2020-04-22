import 'package:flutter/material.dart';

import '../../models/kado.dart';

class DeleteKadoSnackBar extends SnackBar {
  DeleteKadoSnackBar({
    @required TitleKado kado,
    @required VoidCallback onUndo,
  }) : super(
          content: Text(
            kado.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'undo',
            onPressed: onUndo,
          ),
        );
}