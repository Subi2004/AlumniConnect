import 'package:flutter/material.dart';
import 'package:music_play/home_page.dart';
import 'donation_portal.dart';
import 'networking_hub.dart';
import 'welcome_page.dart';
import 'login_page.dart';
import 'filter_page.dart';
import 'profile_page.dart';

class NetworkingHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "AlumniConnect",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 10),
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterDropdown("Graduation Year", "2023"),
                _buildFilterDropdown("Industry", "Technology"),
                _buildFilterDropdown("Location", "New York"),
              ],
            ),
            SizedBox(height: 20),

            // Alumni Cards
            _buildAlumniCard("Jessica Tran", "Class of 2018, Technology"),
            _buildAlumniCard("Michael Smith", "Class of 2015, Finance"),
            _buildAlumniCard("Emily Johnson", "Class of 2020, Education"),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        DropdownButton<String>(
          value: value,
          dropdownColor: Colors.grey[900],
          icon: Icon(Icons.arrow_downward, color: Colors.white),
          items: [value].map((String item) {
            return DropdownMenuItem(
              value: item,
              child: Center(child: Text(item, style: TextStyle(color: Colors.white))),
            );
          }).toList(),
          onChanged: (_) {},
        ),
      ],
    );
  }

  Widget _buildAlumniCard(String name, String detail) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Text(detail, style: TextStyle(color: Colors.grey)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {},
          child: Text("Connect"),
        ),
      ),
    );
  }
}
