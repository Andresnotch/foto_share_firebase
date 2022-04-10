import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'micontenido_event.dart';
part 'micontenido_state.dart';

class MiContenidoBloc extends Bloc<MiContenidoEvent, MiContenidoState> {
  MiContenidoBloc() : super(MiContenidoInitial()) {
    on<MiContenidoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
