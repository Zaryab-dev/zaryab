import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zaryab/practice/pic_screen.dart';
import 'package:zaryab/screen/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.active) {
            if(snapshot.hasData) {
              return const HomeScreen();
            }
          }if(snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return const LoginScreen();
        },
      ),

    );
  }
}

