import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class KadosEvent extends Equatable {
  const KadosEvent();

  @override
  List<Object> get props => [];
}

class LoadKados extends KadosEvent {}

class AddKado extends KadosEvent {
  final Kado kado;

  const AddKado(this.kado);

  @override
  List<Object> get props => [kado];

  @override
  String toString() => 'AddKao { kado: $kado }';
}

class UpdateKado extends KadosEvent {
  final Kado updatedKado;

  const UpdateKado(this.updatedKado);

  @override
  String toString() => 'UpdateKado { updatedKado: $updatedKado }';
}

class DeleteKado extends KadosEvent {
  final Kado kado;

  const DeleteKado(this.kado);

  @override
  List<Object> get props => [kado];

  @override
  String toString() => 'DeleteKado { kado: $kado }';
}
