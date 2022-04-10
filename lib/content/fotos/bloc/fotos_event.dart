part of 'fotos_bloc.dart';

abstract class FotosEvent extends Equatable {
  const FotosEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyFotosEvent extends FotosEvent {}
