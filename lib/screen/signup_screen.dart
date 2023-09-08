import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zaryab/auth_method/firebase_auth.dart';
import 'package:zaryab/screen/login_screen.dart';
import 'package:zaryab/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  Uint8List? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 32,
              ),
              const Expanded(
                  flex: 1,
                  child: Text(
                    'Welcome to \n Firebase',
                    style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(
                height: 3,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(_image!),
                          radius: 80,
                        )
                      : const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.pexels.com/photos/14894654/pexels-photo-14894654.jpeg?auto=compress&cs=tinysrgb&w=800&lazy=load'),
                          radius: 80,
                        ),
                  Positioned(
                      child: IconButton(
                          onPressed: () {
                            getGalleryImage();
                          },
                          icon: const Icon(
                            Icons.add_a_photo_rounded,
                            color: CupertinoColors.activeGreen,
                            size: 25,
                          )))
                ],
              ),
              const SizedBox(
                height: 22,
              ),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                          // image: const DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage('https://images.unsplash.com/photo-1687412192474-8350cdecdb53?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=800&q=60'))
                        ),
                        child: TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              hintText: 'Enter username',
                              prefixIcon: const Icon(Icons.edit),
                              hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      color: CupertinoColors.activeGreen))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                          // image: const DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage('https://images.unsplash.com/photo-1687412192474-8350cdecdb53?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=800&q=60'))
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              hintText: 'Enter your Email',
                              prefixIcon: Icon(Icons.alternate_email),
                              hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      color: CupertinoColors.activeGreen))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                          // image: const DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage('https://images.unsplash.com/photo-1687412192474-8350cdecdb53?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=800&q=60'))
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              hintText: 'Enter your Password',
                              prefixIcon: Icon(Icons.password),
                              hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      color: CupertinoColors.activeGreen))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                          // image: const DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage('https://images.unsplash.com/photo-1687412192474-8350cdecdb53?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=800&q=60'))
                        ),
                        child: TextFormField(
                          controller: bioController,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              hintText: 'Enter your bio',
                              prefixIcon:
                                  const Icon(Icons.align_vertical_bottom_outlined),
                              hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      color: CupertinoColors.activeGreen))),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                          onPressed: () {
                            AuthMethod().getSignUp(emailController.text,
                                passwordController.text, context, _image!);
                            firestoreMethod(context, usernameController.text, bioController.text,
                              emailController.text, passwordController.text,_image!);
                            // uploadImageToStorage(_image!, context);
                          },
                          child: const Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Chip(
                              label: Text('Already have an account?')))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void getGalleryImage() async{
    Uint8List? image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
