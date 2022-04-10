import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;

class FSAccess {
  FutureOr<String> uploadImage(
    int name,
    String pickedImage,
    bool publish,
    DateTime date,
    String title,
  ) async {
    final storageRef = storage.ref();
    final imageRef = storageRef.child("${name}.${pickedImage.split('.').last}");
    await imageRef.putFile(File(pickedImage));
    var download = await imageRef.getDownloadURL();

    try {
      // query para traer el documento con el id del usuario autenticado
      var queryUser = await FirebaseFirestore.instance.collection("user");
      var UID = queryUser.doc("${FirebaseAuth.instance.currentUser!.uid}");

      // query para sacar la data del documento
      var docsRef = await UID.get();
      var listIds = docsRef.data()?["fotosListId"];

      // query para sacar documentos de fshare
      var queryFotos = await FirebaseFirestore.instance.collection("fshare");

      // query de Dart filtrando la info utilizando como referencia la lista de ids de docs del usuario actual
      var myContentList = await queryFotos.add({
        'picture': download,
        'public': publish,
        'publishedAt': date,
        'stars': 1,
        'title': title,
        'username': "${FirebaseAuth.instance.currentUser!.displayName}",
      });

      await UID.set(
        {
          'fotosListId': listIds + [myContentList.id] // Merge List
        },
        SetOptions(
          mergeFields: ['fotosListId'],
        ),
      );
    } catch (e) {
      print("Error al obtener items en espera: $e");
    }

    return download;
  }

  FutureOr<Map<String, dynamic>> getImage(
    String image_id,
  ) {
    return {};
  }

  FutureOr<String> editImage(
    String image_id,
    int name,
    String pickedImage,
    bool publish,
    DateTime date,
    String title,
  ) async {
    final storageRef = storage.ref();
    final imageRef = storageRef.child("${name}.${pickedImage.split('.').last}");
    await imageRef.putFile(File(pickedImage));
    var download = await imageRef.getDownloadURL();

    try {
      // query para traer el documento con el id del usuario autenticado
      var queryUser = await FirebaseFirestore.instance.collection("user");
      var UID = queryUser.doc("${FirebaseAuth.instance.currentUser!.uid}");

      // query para sacar la data del documento
      var docsRef = await UID.get();
      var listIds = docsRef.data()?["fotosListId"];

      // query para sacar documentos de fshare
      var queryFotos = await FirebaseFirestore.instance.collection("fshare");

      // query de Dart filtrando la info utilizando como referencia la lista de ids de docs del usuario actual
      var myContentList = await queryFotos.add({
        'picture': download,
        'public': publish,
        'publishedAt': date,
        'stars': 1,
        'title': title,
        'username': "${FirebaseAuth.instance.currentUser!.displayName}",
      });

      await UID.set(
        {
          'fotosListId': listIds + [myContentList.id] // Merge List
        },
        SetOptions(
          mergeFields: ['fotosListId'],
        ),
      );
    } catch (e) {
      print("Error al obtener items en espera: $e");
    }

    return download;
  }

  FutureOr<void> getPrivateContent() async {
    // query para traer el documento con el id del usuario autenticado
    var queryUser = await FirebaseFirestore.instance
        .collection("user")
        .doc("${FirebaseAuth.instance.currentUser!.uid}");

    // query para sacar la data del documento
    var docsRef = await queryUser.get();
    var userPosts = docsRef.data()?["fotosListId"];

    // query para sacar documentos de fshare
    var queryFotos =
        await FirebaseFirestore.instance.collection("fshare").get();
  }
}
