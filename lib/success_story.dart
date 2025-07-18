import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(SuccessStoriesApp());
}

class SuccessStoriesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SuccessStoriesPage(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black87,
      ),
    );
  }
}

class SuccessStoriesPage extends StatefulWidget {
  @override
  _SuccessStoriesPageState createState() => _SuccessStoriesPageState();
}

class _SuccessStoriesPageState extends State<SuccessStoriesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _isSubmitting = false;

  // Method to save success story to Firestore
  Future<void> _addSuccessStory() async {
    if (_storyController.text.isEmpty || _nameController.text.isEmpty) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _firestore.collection('successStories').add({
        'name': _nameController.text,
        'story': _storyController.text,
        'date': FieldValue.serverTimestamp(),
      });
      _storyController.clear();
      _nameController.clear();
    } catch (e) {
      print('Error adding story: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  // Method to build success story card
  Widget _buildStoryCard(Map<String, dynamic> data) {
    return Card(
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(
          data['name'],
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(data['story'], style: TextStyle(color: Colors.white70)),
        trailing: Text(
          data['date'] != null
              ? DateTime.parse(data['date'].toDate().toString()).toLocal().toString().split(' ')[0]
              : '',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(
          'Success Stories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          Icon(Icons.notifications),
          SizedBox(width: 10),
          Icon(Icons.settings),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Add Success Story Form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Share Your Success Story',
                    style: TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[700],
                      hintText: "Your Name",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _storyController,
                    maxLines: 5,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[700],
                      hintText: "Share your success story...",
                      hintStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _isSubmitting
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: _addSuccessStory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text('Submit Story'),
                  ),
                ],
              ),
            ),

            // Display Success Stories
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('successStories').orderBy('date', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final stories = snapshot.data!.docs;
                  if (stories.isEmpty) {
                    return Center(
                      child: Text(
                        'No success stories found.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: stories.length,
                    itemBuilder: (context, index) {
                      final data = stories[index].data() as Map<String, dynamic>;
                      return _buildStoryCard(data);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.chat, size: 30, color: Colors.white),
              Icon(Icons.settings, size: 30, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
