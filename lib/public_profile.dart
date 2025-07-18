import 'package:flutter/material.dart';

class EditableProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData; // The user data passed from the LoginPage

  EditableProfilePage({required this.userData});

  @override
  _EditableProfilePageState createState() => _EditableProfilePageState();
}

class _EditableProfilePageState extends State<EditableProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _workingStatusController;
  late TextEditingController _courseController;
  late TextEditingController _expertiseDomainController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with the data passed from the LoginPage
    _nameController = TextEditingController(text: widget.userData['name'] ?? '');
    _emailController = TextEditingController(text: widget.userData['email'] ?? '');
    _workingStatusController = TextEditingController(text: widget.userData['workingStatus'] ?? '');
    _courseController = TextEditingController(text: widget.userData['course'] ?? '');
    _expertiseDomainController = TextEditingController(text: widget.userData['expertiseDomain'] ?? '');
    _descriptionController = TextEditingController(text: widget.userData['description'] ?? '');
  }

  @override
  void dispose() {
    // Dispose the controllers when the page is disposed
    _nameController.dispose();
    _emailController.dispose();
    _workingStatusController.dispose();
    _courseController.dispose();
    _expertiseDomainController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                filled: true,
                fillColor: Colors.grey[800],
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.grey[800],
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
              readOnly: true, // Make email field non-editable
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _workingStatusController,
              decoration: InputDecoration(
                labelText: 'Working Status',
                filled: true,
                fillColor: Colors.grey[800],
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _courseController,
              decoration: InputDecoration(
                labelText: 'Course',
                filled: true,
                fillColor: Colors.grey[800],
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _expertiseDomainController,
              decoration: InputDecoration(
                labelText: 'Expertise Domain',
                filled: true,
                fillColor: Colors.grey[800],
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: Colors.grey[800],
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
              maxLines: 4, // Allow the description to span multiple lines
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Here you can add logic to save the changes
                  // For now, we're just showing a message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profile Updated')),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Save Changes', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
