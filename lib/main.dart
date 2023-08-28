import 'package:chat_app_firebase/auth/login_page.dart';
import 'package:chat_app_firebase/helper/helper_function.dart';
import 'package:chat_app_firebase/pages/home_page.dart';
import 'package:chat_app_firebase/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // run the initialization for web
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Constant.apiKey,
        appId: Constant.appId,
        messagingSenderId: Constant.messagingSenderId,
        projectId: Constant.projectId,
      ),
    );
  } else {
    // run the initialization for android
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        _isSignedIn = value;
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? HomePage() : LogInPage(),
    );
  }
}
