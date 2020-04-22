import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/pages.dart';
import '../../bloc/bloc.dart';
import '../widgets.dart';

class LessonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonsBloc, LessonsState>(
      builder: (context, state) {
        if (state is LessonsLoading) {
          return LoadingIndicator();
        } else if (state is LessonsLoaded) {
          final lessons = state.lessons;
          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (BuildContext context, int index) {
              final lesson = lessons[index];
              return LessonItem(
                lesson: lesson,
                onDismissed: (direction) {
                  BlocProvider.of<LessonsBloc>(context)
                      .add(DeleteLesson(lesson));
                },
                onTap: () async {
                  final removedLesson = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) {
                      return LessonDetailsPage(lesson: lesson);
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
