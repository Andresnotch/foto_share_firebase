import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foto_share/content/espera/bloc/pending_bloc.dart';

class ItemEspera extends StatefulWidget {
  final Map<String, dynamic> nonPublicFData;
  final String docID;
  ItemEspera({Key? key, required this.nonPublicFData, required this.docID})
      : super(key: key);

  @override
  State<ItemEspera> createState() => _ItemEsperaState();
}

class _ItemEsperaState extends State<ItemEspera> {
  bool _switchValue = false;
  @override
  void initState() {
    _switchValue = widget.nonPublicFData["public"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                "${widget.nonPublicFData["picture"]}",
                fit: BoxFit.cover,
              ),
            ),
            BlocBuilder<PendingBloc, PendingState>(
              builder: (context, state) {
                return SwitchListTile(
                  title: Text("${widget.nonPublicFData["title"]}"),
                  subtitle:
                      Text("${widget.nonPublicFData["publishedAt"].toDate()}"),
                  value: _switchValue,
                  onChanged: (newVal) {
                    setState(() {
                      context
                          .read<PendingBloc>()
                          .add(PublishDisabledFotoEvent(photo: widget.docID));
                      _switchValue = newVal;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
