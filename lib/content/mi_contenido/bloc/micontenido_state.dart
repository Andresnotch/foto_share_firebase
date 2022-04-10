part of 'micontenido_bloc.dart';

abstract class MiContenidoState extends Equatable {
  const MiContenidoState();

  @override
  List<Object> get props => [];
}

class MiContenidoInitial extends MiContenidoState {}

class MiContenidoLoadingState extends MiContenidoState {}

class MiContenidoEmptyState extends MiContenidoState {}

class MiContenidoSuccessState extends MiContenidoState {}
