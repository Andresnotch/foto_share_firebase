part of 'picture_bloc.dart';

abstract class PictureEvent extends Equatable {
  const PictureEvent();

  @override
  List<Object?> get props => [];
}

class ChangeImageEvent extends PictureEvent {}

class UploadImageEvent extends PictureEvent {
  final String title;
  final DateTime date;
  final bool publish;

  UploadImageEvent(
      {required this.title, required this.date, required this.publish});
  @override
  List<Object?> get props => [title, date, publish];
}
