import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'sign_up_page.dart';
import 'sign_in_page.dart';
import 'homepage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();    try {

      await Firebase.initializeApp(
        options: const FirebaseOptions(apiKey: "AIzaSyBR-ZYDXzVAYhON_ds81fIV-LgSqREj6iA",
    authDomain: "green-square-2e83d.firebaseapp.com",
    projectId: "green-square-2e83d",
    storageBucket: "green-square-2e83d.appspot.com",
    messagingSenderId: "240952480837",
    appId: "1:240952480837:web:16ca72d482943b051b7f2c",
    measurementId: "G-NBT65RR6SD"));

    print('Firebase initialized');

  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(GreenSquareApp());
}

class GreenSquareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GREEN SQUARE',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/sign-in', 
      routes: {
        '/home': (context) => HomePage(),
         '/sign-up': (context) => SignUpPage(),
        '/sign-in': (context) => SignInPage(),
        
      },
    );
  }
}
