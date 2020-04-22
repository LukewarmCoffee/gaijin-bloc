import 'package:equatable/equatable.dart';

import '../../models/kado.dart';

abstract class KadosState extends Equatable {
  const KadosState();

  @override
  List<Object> get props => [];
}

class KadosLoading extends KadosState {}

class KadosLoaded extends KadosState {
  final List<Kado> kados;

  const KadosLoaded([this.kados = const[]]);

  @override
  List<Object> get props => [kados];

  @override
  String toString() {
    return 'KadosLoaded { kados: $kados }';
  }
}

class KadosNotLoaded extends KadosState {}