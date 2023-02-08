import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/singnup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBKgLlSay8yJXZQI99WnS9vbiqFkxVYVss",
      appId: "1:1069805735577:web:28f34d9f38656f07b2b208",
      messagingSenderId: "1069805735577",
      projectId: "instagramclone-f1c85",
      storageBucket: "instagramclone-f1c85.appspot.com",
    )).then((value) => debugPrint("Firebase initialize in web"));
  }
  await Firebase.initializeApp()
      .then((value) => debugPrint("Firebase Initialized in mobile"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SignupScreen(),
      // home: const ResponsiveLayout(
      //   webScreenLayout: WebScreenLayout(),
      //   mobileScreenLayout: MobileScreenLayout(),
      // ),
    );
  }
}
//1.22.42