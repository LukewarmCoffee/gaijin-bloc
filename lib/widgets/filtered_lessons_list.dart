import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pages/pages.dart';
import '../bloc/bloc.dart';
import 'widgets.dart';

class FilteredLessonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredLessonsBloc, FilteredLessonsState>(
      builder: (context, state) {
        if (state is FilteredLessonsLoading) {
          return LoadingIndicator();
        } else if (state is FilteredLessonsLoaded) {
          final lessons = state.filteredLessons;
          return ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (BuildContext context, int index) {
              final lesson = lessons[index];
              return Container(
                color: lesson.completed ? Colors.teal : Colors.red,
                child: LessonItem(
                  lesson: lesson,
                  onDismissed: (direction) {
                    BlocProvider.of<LessonsBloc>(context)
                        .add(DeleteLesson(lesson));
                  },
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return LessonDetailsPage(
                            lesson: lesson,
                            setProgress: (page) {
                              if (page == lesson.kadoIds.length - 1)
                                BlocProvider.of<FilteredLessonsBloc>(context)
                                    .add(UpdateFilteredLesson(lesson.copyWith(
                                        progress: page, completed: true)));
                              else if (page < lesson.kadoIds.length - 1)
                                BlocProvider.of<FilteredLessonsBloc>(context)
                                    .add(UpdateFilteredLesson(
                                        lesson.copyWith(progress: page)));
                            });
                      }),
                    );
                  },
                ),
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
