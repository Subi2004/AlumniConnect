/*import "package:flutter/material.dart";

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_placeholder.png'),
            ),
            SizedBox(height: 10),
            Text('AlumniConnect', style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(height: 5),
            Text('Stay connected with alumni network.',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('112', style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text('Connections', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Column(
                  children: [
                    Text('211', style: TextStyle(color: Colors.white, fontSize: 20)),
                    Text('Connections', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Text('Connect', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}*/
