import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../models/lesson.dart';

class LessonItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Lesson lesson;

  LessonItem({
    @required this.onDismissed,
    @required this.onTap,
    @required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Keys.lessonItem(lesson.id),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Hero(
          tag: '${lesson.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              lesson.title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }
}
