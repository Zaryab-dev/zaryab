import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zaryab/practice/pic_screen.dart';
import 'package:zaryab/screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',style: TextStyle(color: Colors.white),),
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
              SizedBox(height: 32,),
              const Expanded(
                  flex: 1,
                  child: Text('Welcome to \n Firebase',style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
              SizedBox(height: 23,),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
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
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(10,0,10,0),
                              hintText: 'Enter your Email',
                              prefixIcon: const Icon(Icons.alternate_email),
                              hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(color: CupertinoColors.activeGreen)
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                          // image: const DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage('https://images.unsplash.com/photo-1687412192474-8350cdecdb53?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=800&q=60'))
                        ),
                        child: TextFormField(
                          controller: passController,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.fromLTRB(10,0,10,0),
                              hintText: 'Enter your Password',
                              prefixIcon: Icon(Icons.password),
                              hintStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(color: CupertinoColors.activeGreen)
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(height: 50,),
                      ElevatedButton(
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                          onPressed: (){
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passController.text).then((value) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                            });
                          }, child: const Center(child: Text('Login',style: TextStyle(color: Colors.white),),)),
                      SizedBox(height: 10,),
                      InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                          },
                          child: const Chip(label: Text('Don\'t have an account?')))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
