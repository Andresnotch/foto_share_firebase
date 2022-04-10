part of 'fotos_bloc.dart';

abstract class FotosState extends Equatable {
  const FotosState();

  @override
  List<Object> get props => [];
}

class FotosInitial extends FotosState {}

class FotosSuccessState extends FotosState {
  // lista de elementos de firebase "fshare collection"
  final List<Map<String, dynamic>> myData;

  FotosSuccessState({required this.myData});
  @override
  List<Object> get props => [myData];
}

class FotosErrorState extends FotosState {}

class FotosEmptyState extends FotosState {}

class FotosLoadingState extends FotosState {}
