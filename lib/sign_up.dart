import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AlumniRegistration extends StatefulWidget {
  @override
  _AlumniRegistrationState createState() => _AlumniRegistrationState();
}

class _AlumniRegistrationState extends State<AlumniRegistration> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController(); // Controller for password
  final _graduationYearController = TextEditingController();
  final _majorController = TextEditingController();
  final _professionController = TextEditingController();
  final _locationController = TextEditingController();
  final _workplaceController = TextEditingController(); // New controller for workplace
  final _workLocationController = TextEditingController(); // New controller for work location
  final _aboutMeController = TextEditingController(); // New controller for about me
  final _successStoriesController = TextEditingController(); // New controller for success stories

  Future<void> _submitData() async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Store additional user data in Firestore
      DocumentReference docRef = await _firestore.collection('alumni').add({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'graduationYear': _graduationYearController.text.trim(),
        'major': _majorController.text.trim(),
        'profession': _professionController.text.trim(),
        'location': _locationController.text.trim(),
        'workplace': _workplaceController.text.trim(),
        'workLocation': _workLocationController.text.trim(),
        'aboutMe': _aboutMeController.text.trim(),
        'successStories': _successStoriesController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Store the document ID with the user in Firebase Auth
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': _emailController.text.trim(),
        'name': _emailController.text.split('@')[0],
      });

      debugPrint("Alumni data stored successfully!");

      Navigator.pushNamed(context, '/login'); // Navigate to login page
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "AlumniConnect",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: [
          _buildPage1(),
          _buildPage2(),
          _buildPage3(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Personal"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Work"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Details"),
        ],
      ),
    );
  }

  Widget _buildPage1() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                // TODO: Implement upload functionality
              },
              child: Text("Upload Profile Picture"),
            ),
            SizedBox(height: 20),
            _buildTextField("Full Name", _nameController),
            _buildTextField("Email Address", _emailController),
            _buildPasswordField("Password", _passwordController),
            _buildTextField("Graduation Year", _graduationYearController),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                setState(() {
                  _currentPageIndex = 1;
                });
              },
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildTextField("Major", _majorController),
            _buildTextField("Current Profession", _professionController),
            _buildTextField("Location", _locationController),
            _buildTextField("Workplace", _workplaceController),
            _buildTextField("Work Location", _workLocationController),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                setState(() {
                  _currentPageIndex = 2;
                });
              },
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage3() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _buildTextArea("About Me", _aboutMeController),
            _buildTextArea("Success Stories", _successStoriesController),
            SizedBox(height: 20),
            Text(
              "Connect Social Media:",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.link, color: Colors.green, size: 30),
                SizedBox(width: 20),
                Icon(Icons.facebook, color: Colors.green, size: 30),
                SizedBox(width: 20),
                Icon(Icons.email, color: Colors.green, size: 30),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {
                await _submitData();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registration successful!')),
                );
              },
              child: Text("Submit Registration"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[800],
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0
        ),
      child: TextField( controller: controller, obscureText: true, style: TextStyle(color: Colors.white), decoration: InputDecoration( filled: true, fillColor: Colors.grey[800], labelText: label, labelStyle: TextStyle(color: Colors.grey), border: OutlineInputBorder( borderRadius: BorderRadius.circular(8), ), ), ), ); }

  Widget _buildTextArea(String label, TextEditingController controller) { return Padding( padding: const EdgeInsets.symmetric(vertical: 8.0), child: TextField( controller: controller, maxLines: 3, style: TextStyle(color: Colors.white), decoration: InputDecoration( filled: true, fillColor: Colors.grey[800], labelText: label, labelStyle: TextStyle(color: Colors.grey), border: OutlineInputBorder( borderRadius: BorderRadius.circular(8), ), ), ), ); } }