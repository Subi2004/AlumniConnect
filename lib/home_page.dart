import 'package:flutter/material.dart';
import 'event_page.dart';
import 'explore_page.dart';
import 'filter_page.dart';
import 'messagesPage.dart';
import 'networking_hub.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'AlumniConnect',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.message, color: Colors.white),
            onPressed: () {
              // Navigate to messages page or handle message action
              Navigator.push(context, MaterialPageRoute(builder: (context) => MessagesPage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Navigate to settings page if needed
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Section
              Text(
                "Hi, User 👋",
                style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Manage events easily",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),

              // Event Card Section
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    /*Image.asset(
                      'assets/event_image.png',
                      height: 160,
                      fit: BoxFit.cover,
                    ),*/
                    SizedBox(height: 10),
                    Text(
                      "Alumni Reunion Event",
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Experience the joy of meeting old friends and colleagues.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>EventConnectPage()));
                      },
                      child: Text("Explore Events"),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Options Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Add functionality for Events button
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EventConnectPage()));
                    },
                    child: _buildOptionCard(Icons.event, "Events"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NetworkingHub()));
                    },
                    child: _buildOptionCard(Icons.people, "Support"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ExplorePage()));
                    },
                    child: _buildOptionCard(Icons.map, "Explore"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AlumniConnectPage()));
                    },
                    child: _buildOptionCard(Icons.favorite, "Find"),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Recent Updates
              Text(
                "Recent Updates",
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/event_image.png'),
                ),
                title: Text(
                  "Alumni Career Development",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  "Upgrade your skills with the latest career opportunities.",
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text("Explore"),
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/event_image.png'),
                ),
                title: Text(
                  "Alumni Spotlight",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  "Discover achievements of alumni around the globe.",
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text("Read"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 32, color: Colors.green),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
