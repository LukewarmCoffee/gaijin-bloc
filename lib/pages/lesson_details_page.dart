import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaijin_bloc/widgets/kados/sentence_kado_item.dart';

import '../models/kado.dart';
import '../widgets/widgets.dart';
import '../models/lesson.dart';
import '../bloc/bloc.dart';

class LessonDetailsPage extends StatelessWidget {
  final Lesson lesson;

  LessonDetailsPage({@required this.lesson});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KadosBloc, KadosState>(
      builder: (context, state) {
        if (state is KadosLoading) {
          return LoadingIndicator();
        } else if (state is KadosLoaded) {
          final List<Kado> kados = lesson.kadoIds
              .map((kadoId) =>
                  state.kados.firstWhere((kado) => kado.id == kadoId))
              .toList();
          return Scaffold(
            appBar: AppBar(
              title: Text(lesson.title),
            ),
            body: kados == null
                ? Container()
                : PageView.builder(
                    itemCount: kados.length,
                    itemBuilder: (BuildContext context, int index) {
                      final kado = kados[index];
                      if (kado is TitleKado)
                        return TitleKadoItem(kado: kado);
                      else if (kado is VocabKado)
                        return VocabKadoItem(kado: kado);
                      else if (kado is SentenceKado)
                        return SentenceKadoItem(kado: kado);
                      else
                        return Container(child: Text('you never should have come here!'),);
                    },
                  ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
