import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/picture_bloc.dart';

class Publicar extends StatefulWidget {
  Publicar({Key? key}) : super(key: key);

  @override
  State<Publicar> createState() => _PublicarState();
}

class _PublicarState extends State<Publicar> {
  DateTime _selectedDate = DateTime.now();
  var title = TextEditingController();
  var date = TextEditingController();
  var publish = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        BlocConsumer<PictureBloc, PictureState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                BlocProvider.of<PictureBloc>(context).add(
                  ChangeImageEvent(),
                );
              },
              child: _imageFromState(state),
            );
          },
        ),
        Form(
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Title'),
              controller: title,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Date'),
              readOnly: true,
              controller: date,
              onTap: () async => _selectDate(context),
            ),
            SwitchListTile(
              title: Text('Publicar'),
              value: publish,
              onChanged: (val) {
                publish = val;
                setState(() {});
              },
            ),
            ElevatedButton(
              child: const Text('Guardar'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
              ),
              onPressed: () {
                BlocProvider.of<PictureBloc>(context).add(
                  UploadImageEvent(
                    title: title.text,
                    date: DateTime.parse(date.text),
                    publish: publish,
                  ),
                );
              },
            )
          ],
        ))
      ]),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2010),
        lastDate: DateTime(2023));
    if (picked == null) {
      picked = DateTime.now();
    }
    TimeOfDay? timepicked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (timepicked == null) {
      timepicked = TimeOfDay.now();
    }
    if (picked != _selectedDate) {
      _selectedDate = picked;
      if (timepicked != TimeOfDay.fromDateTime(_selectedDate)) {
        _selectedDate = _selectedDate.add(Duration(
          hours: timepicked.hour,
          minutes: timepicked.minute,
        ));
      }
      date.text = _selectedDate.toLocal().toString();
      setState(() {});
    }
  }

  Image _imageFromState(PictureState state) {
    if (state is PictureSelectedState) {
      return Image(
        image: FileImage(File(state.picture)),
        height: 200,
        width: 300,
      );
    } else if (state is ImageUploadedState) {
      return Image(
        image: FileImage(File(state.picture)),
        height: 200,
        width: 300,
      );
    } else {
      return Image.network(
          'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=640');
    }
  }
}
