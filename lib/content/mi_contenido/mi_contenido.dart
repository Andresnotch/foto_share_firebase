import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:foto_share/content/mi_contenido/bloc/micontenido_bloc.dart';

class MiContenido extends StatefulWidget {
  MiContenido({Key? key}) : super(key: key);

  @override
  State<MiContenido> createState() => _MiContenidoState();
}

class _MiContenidoState extends State<MiContenido> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<MiContenidoBloc, MiContenidoState>(
          listener: (context, state) {},
          builder: (coxtext, state) {
            if (state is MiContenidoLoadingState) {
              return ListView.builder(
                itemCount: 25,
                itemBuilder: (BuildContext context, int index) {
                  return YoutubeShimmer();
                },
              );
            } else if (state is MiContenidoEmptyState) {
              return Center(child: Text("No hay datos por mostrar"));
            } else if (state is MiContenidoSuccessState) {
              return Column(
                children: [
                  RefreshIndicator(
                    onRefresh: () {
                      context.read<FotosBloc>().add(GetAllMyFotosEvent());
                      return Future.delayed(
                        Duration(seconds: 0),
                      );
                    },
                    child: ListView.builder(
                      itemCount: state.myData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemFoto(nonPublicFData: state.myData[index]);
                      },
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
