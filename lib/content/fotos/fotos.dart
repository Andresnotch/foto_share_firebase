import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:foto_share/content/fotos/bloc/fotos_bloc.dart';
import 'package:foto_share/content/fotos/item_foto.dart';

class Fotos extends StatelessWidget {
  const Fotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FotosBloc, FotosState>(
      listener: (context, state) {
        if (state is FotosErrorState) {
          // show snackbar
        }
      },
      builder: (coxtext, state) {
        if (state is FotosLoadingState) {
          return ListView.builder(
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return YoutubeShimmer();
            },
          );
        } else if (state is FotosEmptyState) {
          return Center(child: Text("No hay datos por mostrar"));
        } else if (state is FotosSuccessState) {
          return RefreshIndicator(
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
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
