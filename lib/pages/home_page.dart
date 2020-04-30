import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import '../utils/utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateReviewBloc, CreateReviewState>(
      builder: (context, state) {
        if (state is CreateReviewLoading) {
          return LoadingIndicator();
        } else if (state is CreateReviewLoaded) {
          final lessonKadoIds = state.lessonKadoIds;
          return BlocListener<ProgressBloc, ProgressState>(
            listener: (context, state) {
              if (state is ProgressLoaded && state.lessonNeeded)
                BlocProvider.of<LessonsBloc>(context).add(
                  AddLesson(Lesson(
                    title: 'review',
                    kadoIds: lessonKadoIds,
                  )),
                );
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('Lessons'),
              ),
              body: LessonsList(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addKado);
                },
                child: Icon(Icons.add),
              ),
              drawer: MainDrawer(),
            ),
          );
        } else
          return Container();
      },
    );
  }
}
