import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foto_share/modules/fsAccess.dart';
import 'package:image_picker/image_picker.dart';

part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  PictureBloc() : super(PictureInitial()) {
    on<ChangeImageEvent>(_onChangeImage);
    on<UploadImageEvent>(_uploadImage);
  }

  String pickedImage = '';

  void _onChangeImage(ChangeImageEvent event, Emitter emit) async {
    try {
      String? img = await _pickImage();
      if (img != null)
        emit(PictureSelectedState(picture: img));
      else
        throw Exception();
    } catch (e) {
      emit(PictureErrorState(errorMsg: "Error: No se pudo cargar imagen"));
    }
  }

  Future<String?> _pickImage() async {
    final picker = ImagePicker();
    final XFile? chosenImage = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
      imageQuality: 85,
    );
    pickedImage = chosenImage != null ? chosenImage.path : '';
    return chosenImage != null ? chosenImage.path : '';
  }

  FutureOr<String> _uploadImage(UploadImageEvent event, Emitter emit) async {
    if (pickedImage == '') {
      emit(ImageMissingState());
      return '';
    }
    var name = 1000000 + Random().nextInt(1000000);
    String downloadURL = await FSAccess()
        .uploadImage(name, pickedImage, event.publish, event.date, event.title);
    emit(ImageUploadedState(picture: pickedImage, downloadURL: downloadURL));
    return '';
  }
}
