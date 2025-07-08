import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDDkHPr1UmfSxUPESwKfM-ru_o_lcB8_mI",
          authDomain: "ecommerce-flutter-cb916.firebaseapp.com",
          projectId: "ecommerce-flutter-cb916",
          storageBucket: "ecommerce-flutter-cb916.firebasestorage.app",
          messagingSenderId: "346793524455",
          appId: "1:346793524455:web:1ea2fed477d36536837642",
          measurementId: "G-BZ8RV525VJ"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: FirebaseAuth.instance.currentUser != null ? HomeScreen() : LoginScreen(),
    );
  }
}
