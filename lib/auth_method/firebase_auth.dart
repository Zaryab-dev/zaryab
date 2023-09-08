import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:zaryab/utils.dart';

class AuthMethod {
  void getSignUp(String email, password, BuildContext context, Uint8List file) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // uploadImageToStorage(file, context);
      Utils().showSnackbar('User Registered Successfully!', context);
      firestoreMethod(
        context,
        'username',
        'bio',
        email,
        password,
        file,
      );
    }).onError((error, stackTrace) {
      Utils().showSnackbar(error.toString(), context);
    });
  }
}

  firestoreMethod(BuildContext context, String username, bio, email, password,
      Uint8List file) async {
    final photoUrl = await uploadImageToStorage(file, context);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;
    firestore
        .collection('UserDate')
        .doc(_auth.currentUser!.uid)
        .set({
      'username': username,
      'email': email,
      'password': password,
      'bio': bio,
      'date': DateTime.now(),
      'profile': photoUrl,
    })
        .then((value) => Utils().showSnackbar('Uploaded!', context))
        .onError((error, stackTrace) {
      Utils().showSnackbar(error.toString(), context);
    });
  }

uploadImageToStorage(Uint8List file, BuildContext context) async{
  Reference reference = FirebaseStorage.instance.ref().child('foldername');
  UploadTask uploadTask = reference.putData(file);
  await Future.value(uploadTask);
  TaskSnapshot snapshot = await uploadTask;
  var newUrl = snapshot.ref.getDownloadURL();
  return newUrl;
  FirebaseFirestore.instance.collection('UserDate').doc().set({
    'profile' : newUrl.toString(),
  }).then((value) => Utils().showSnackbar('Profile set successfuly!', context)).onError((error, stackTrace) => Utils().showSnackbar(error.toString(), context));
}
