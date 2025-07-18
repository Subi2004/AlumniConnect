import 'package:flutter/material.dart';
import 'package:music_play/home_page.dart';
import 'donation_portal.dart';
import 'networking_hub.dart';
import 'welcome_page.dart';
import 'login_page.dart';
import 'filter_page.dart';
import 'profile_page.dart';
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'AlumniConnect',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Engage with your alma mater community',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Join', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
