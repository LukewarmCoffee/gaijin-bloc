import 'dart:async';
import 'dart:core';

import 'kado_entity.dart';

abstract class KadosRepository {
  /// Loads kados first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the kados from a Web Client.
  Future<List<KadoEntity>> loadKados();

  // Persists kados to local disk and the web
  Future saveKados(List<KadoEntity> kados);
}