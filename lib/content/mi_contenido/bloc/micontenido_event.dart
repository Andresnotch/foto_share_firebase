part of 'micontenido_bloc.dart';

abstract class MiContenidoEvent extends Equatable {
  const MiContenidoEvent();

  @override
  List<Object> get props => [];
}

class GetMyContentEvent extends MiContenidoEvent {}
