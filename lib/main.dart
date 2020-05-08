import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'models/models.dart';
import 'pages/pages.dart';
import 'repository/repository.dart';
import 'bloc/bloc.dart';
import 'utils/utils.dart';

void main() {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LessonsBloc>(
          create: (context) => LessonsBloc(
            lessonsRepository: const LessonsConcreteRepository(
              localStorage: const LessonsFileStorage(
                '__lessson15__',
                getApplicationDocumentsDirectory,
              ),
            ),
          )..add(LoadLessons()),
        ),
        BlocProvider<KadosBloc>(
          create: (context) => KadosBloc(
            kadosRepository: const KadoConcreteRepository(
              localStorage: const KadoFileStorage(
                '__kad2__',
                getApplicationDocumentsDirectory,
              ),
            ),
          )..add(LoadKados()),
        ),
        BlocProvider<WordsBloc>(
          create: (context) => WordsBloc(
            wordsRepository: const WordConcreteRepository(
              localStorage: const WordFileStorage(
                '__word9__',
                getApplicationDocumentsDirectory,
              ),
            ),
          )..add(LoadWords()),
        ),
        BlocProvider<CreateReviewBloc>(
          create: (context) => CreateReviewBloc(
            kadosBloc: BlocProvider.of<KadosBloc>(context),
            wordsBloc: BlocProvider.of<WordsBloc>(context),
          ),
        ),
        BlocProvider<FilteredLessonsBloc>(
          create: (context) => FilteredLessonsBloc(
            lessonsRepository: const FilteredLessonsConcreteRepository(
              localStorage: const LessonsFileStorage(
                '__filtered_lesson_2__',
                getApplicationDocumentsDirectory,
              ),
            ),
            lessonsBloc: BlocProvider.of<LessonsBloc>(context),
            createReviewBloc: BlocProvider.of<CreateReviewBloc>(context),
          )..add(LoadFilteredLessons()),
        ),
      ],
      child: GaijinApp(),
    ),
  );
}

class GaijinApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: MainTheme.theme,
      routes: {
        Routes.home: (context) {
          return HomePage();//MultiBlocProvider(providers: [], child: HomePage());
        },
        Routes.addKado: (context) {
          return AddEditPage(
            key: Keys.addKadoScreen,
            onSave: (title, subtitle) {
              BlocProvider.of<KadosBloc>(context).add(
                AddKado(TitleKado(title: title, subtitle: subtitle)),
              );
            },
            isEditing: false,
          );
        },
        Routes.addWord: (context) {
          return AddEditWordPage(
            key: Keys.addKadoScreen,
            onSave: (japanese, kana, english, definition) {
              BlocProvider.of<WordsBloc>(context).add(
                AddWord(Word(
                  japanese: japanese,
                  kana: kana,
                  english: english,
                  definition: definition,
                )),
              );
            },
            isEditing: false,
          );
        },
        Routes.wordsPage: (context) {
          return WordsPage();
        }
      },
    );
  }
}
