import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaijin_bloc/widgets/kados/sentence_kado_item.dart';

import '../models/kado.dart';
import '../widgets/widgets.dart';
import '../models/lesson.dart';
import '../bloc/bloc.dart';

class LessonDetailsPage extends StatefulWidget {
  final Lesson lesson;
  final Function(int) setProgress;

  LessonDetailsPage({@required this.lesson, this.setProgress});

  @override
  _LessonDetailsPageState createState() => _LessonDetailsPageState();
}

class _LessonDetailsPageState extends State<LessonDetailsPage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.lesson.progress);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KadosBloc, KadosState>(
      builder: (context, state) {
        if (state is KadosLoading) {
          return LoadingIndicator();
        } else if (state is KadosLoaded) {
          final List<Kado> kados = widget.lesson.kadoIds
              .map((kadoId) =>
                  state.kados.firstWhere((kado) => kado.id == kadoId))
              .toList();
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.lesson.title),
            ),
            body: kados == null
                ? Container()
                : PageView.builder(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: widget.setProgress,
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
                        return Container(
                          child: Text('you never should have come here!'),
                        );
                    },
                  ),
            floatingActionButton: FloatingActionButton(
              child: Text('next'),
              onPressed: () => _pageController.nextPage(
                  duration: Duration(milliseconds: 100), curve: Curves.easeIn),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
