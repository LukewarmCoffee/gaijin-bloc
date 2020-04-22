import 'dart:async';

import 'kado_entity.dart';
import 'kados_repository.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class KadoWebClient implements KadosRepository {
  final Duration delay;

  const KadoWebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  @override
  Future<List<KadoEntity>> loadKados() async {
    return Future.delayed(
        delay,
        () => [
              TitleKadoEntity(
                'Buy food for da kitty',
                'With the chickeny bits!',
                '1',
              ),
              TitleKadoEntity(
                'Find a Red Sea dive trip',
                'Echo vs MY Dream',
                '2',
              ),
              TitleKadoEntity(
                'Title Only',
                '',
                '3',
              ),
              TitleKadoEntity(
                '',
                'Body Only',
                '4',
              ),
              TitleKadoEntity(
                'Sip Margaritas',
                'on the beach',
                '5',
              ),
              VocabKadoEntity(
                '1',
                false,
                '6',
              ),
              VocabKadoEntity(
                '2',
                true,
                '7',
              ),
              SentenceKadoEntity(
                ['1','2','1'],
                '',
                false,
                '8',
              ),
              SentenceKadoEntity(
                ['1','3','1'],
                'this one has been learned',
                true,
                '9',
              ),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> saveKados(List<KadoEntity> kados) async {
    return Future.value(true);
  }
}
