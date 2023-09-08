import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaryab/screen/login_screen.dart';
import 'package:zaryab/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 100,
                      backgroundImage: MemoryImage(_image!),
                      backgroundColor: CupertinoColors.systemGrey6,
                    )
                  : const CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1687412192474-8350cdecdb53?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=800&q=60'),
                      backgroundColor: CupertinoColors.systemGrey6,
                    ),
              IconButton(
                  onPressed: () {
                    getImage();
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 34,
                  )),
              IconButton(onPressed: () {
                FirebaseAuth.instance.signOut().then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())));
              }, icon: Icon(Icons.logout)),
              IconButton(onPressed: () {
                uploadImage(_image!);
              }, icon: Icon(Icons.upload_outlined))
            ],
          ),
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? _file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    return null;
  }
  void getImage() async{
    final file = await pickImage(ImageSource.gallery);
    setState(() {
      _image = file;
    });
  }
  Future<Future<void>?> uploadImage(Uint8List file) async{
    Reference reference = FirebaseStorage.instance.ref('foldername/').child(DateTime.now().toString());
    UploadTask uploadTask = reference.putData(file);
    await Future.value(uploadTask).then((value)  async{
      var newUrl = reference.getDownloadURL();
      FirebaseFirestore.instance.collection('UserData').doc(DateTime.now().toString()).set({
    'photoUrl' : newUrl.toString(),
    }).then((value) => Utils().showSnackbar('Success', context)).onError((error, stackTrace) => Utils().showSnackbar(error.toString(), context));
    });
    return null;
  }
}
