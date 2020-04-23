import 'dart:async';
import 'dart:core';
import 'package:meta/meta.dart';

import 'kados_repository.dart';
import 'kado_entity.dart';
import 'kado_web_client.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class KadoConcreteRepository implements KadosRepository {
  final KadosRepository localStorage;
  final KadosRepository webClient;

  const KadoConcreteRepository({
    @required this.localStorage,
    this.webClient = const KadoWebClient(),
  });

  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  @override
  Future<List<KadoEntity>> loadKados() async {
    try {
      return await localStorage.loadKados();
    } catch (e) {
      final kados = await webClient.loadKados();
      print('coiunt load kados');
      await localStorage.saveKados(kados);

      return kados;
    }
  }

  // Persists notes to local disk and the web
  @override
  Future saveKados(List<KadoEntity> kados) {
    return Future.wait<dynamic>([
      localStorage.saveKados(kados),
      webClient.saveKados(kados),
    ]);
  }
}