import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'kado_entity.dart';
import 'kados_repository.dart';

class KadoFileStorage implements KadosRepository {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const KadoFileStorage(
    this.tag,
    this.getDirectory,
  );

  @override
  Future<List<KadoEntity>> loadKados() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final kados = (json['kados'])
        .map<KadoEntity>((kado) => KadoEntity.fromJson(kado))
        .toList();

    return kados;
  }

  @override
  Future<File> saveKados(List<KadoEntity> kados) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'kados': kados.map((kado) => kado.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/GaijinAppStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}