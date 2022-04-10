part of 'picture_bloc.dart';

abstract class PictureState extends Equatable {
  const PictureState();

  @override
  List<Object?> get props => [];
}

class PictureInitial extends PictureState {}

class PictureErrorState extends PictureState {
  final String errorMsg;

  PictureErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}

class PictureSelectedState extends PictureState {
  final String picture;

  PictureSelectedState({required this.picture});
  @override
  List<Object?> get props => [picture];
}

class ImageMissingState extends PictureState {}

class ImageUploadedState extends PictureState {
  final String picture;
  final String downloadURL;

  ImageUploadedState({required this.picture, required this.downloadURL});
  @override
  List<Object?> get props => [picture, downloadURL];
}
