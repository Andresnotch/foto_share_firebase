part of 'pending_bloc.dart';

abstract class PendingEvent extends Equatable {
  const PendingEvent();

  @override
  List<Object> get props => [];
}

class GetAllMyDisabledFotosEvent extends PendingEvent {}

class PublishDisabledFotoEvent extends PendingEvent {
  final String photo;

  PublishDisabledFotoEvent({required this.photo});

  @override
  List<Object> get props => [photo];
}
