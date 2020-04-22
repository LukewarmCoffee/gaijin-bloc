import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/kados/kados_repository.dart';
import '../../models/kado.dart';
import 'kados_event.dart';
import 'kados_state.dart';


class KadosBloc extends Bloc<KadosEvent, KadosState> {
  final KadosRepository kadosRepository;

  KadosBloc({@required this.kadosRepository});

  @override
  KadosState get initialState => KadosLoading();

  @override
  Stream<KadosState> mapEventToState(KadosEvent event) async* {
    if (event is LoadKados) {
      yield* _mapLoadKadosToState();
    } else if (event is AddKado) {
      yield* _mapAddKadoToState(event);
    } else if (event is UpdateKado) {
      yield* _mapUpdateKadoToState(event);
    } else if (event is DeleteKado) {
      yield* _mapDeleteKadoToState(event);
    }
  }

  Stream<KadosState> _mapLoadKadosToState() async* {
    try {
      final kados = await this.kadosRepository.loadKados();
      yield KadosLoaded(
        kados.map(Kado.fromEntity).toList(),
      );
    } catch (_) {
      yield KadosNotLoaded();
    }
  }

  Stream<KadosState> _mapAddKadoToState(AddKado event) async* {
    if (state is KadosLoaded) {
      final List<Kado> updatedKados = List.from((state as KadosLoaded).kados)
        ..add(event.kado);
      yield KadosLoaded(updatedKados);
      _saveKados(updatedKados);
    }
  }

  Stream<KadosState> _mapUpdateKadoToState(UpdateKado event) async* {
    if (state is KadosLoaded) {
      final List<Kado> updatedKados = (state as KadosLoaded).kados.map((kado) {
        return kado.id == event.updatedKado.id ? event.updatedKado : kado;
      }).toList();
      yield KadosLoaded(updatedKados);
      _saveKados(updatedKados);
    }
  }

  Stream<KadosState> _mapDeleteKadoToState(DeleteKado event) async* {
    if (state is KadosLoaded) {
      final updatedKados = (state as KadosLoaded)
          .kados
          .where((kado) => kado.id != event.kado.id)
          .toList();
      yield KadosLoaded(updatedKados);
      _saveKados(updatedKados);
    }
  }

  Future _saveKados(List<Kado> kados) {
    return kadosRepository.saveKados(
      kados.map((kado) => kado.toEntity()).toList(),
    );
  }
}
