import 'package:flutter/material.dart';
import 'package:music_play/home_page.dart';
import 'add_event.dart';
import 'donation_portal.dart';
import 'event_page.dart';
import 'explore_page.dart';
import 'messagesPage.dart';
import 'networking_hub.dart';
import 'post_page.dart';
import 'public_profile.dart';
import 'sign_up.dart';
import 'success_story.dart';
import 'support_page.dart';
import 'welcome_page.dart';
import 'login_page.dart';
import 'filter_page.dart';
import 'profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alumni Connect',
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home:MessagesPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/filters': (context) => AlumniConnectPage(),
        //'/profile': (context) => EditableProfilePage(),
      },
    );
  }
}