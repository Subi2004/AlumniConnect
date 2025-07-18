import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPostsPage extends StatefulWidget {
  @override
  _MyPostsPageState createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _editPost(String postId, String newContent) async {
    if (newContent.trim().isEmpty) return;

    try {
      await _firestore.collection('posts').doc(postId).update({'content': newContent});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Post updated successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update post: $e")),
      );
    }
  }

  void _deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Post deleted successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete post: $e")),
      );
    }
  }

  void _showEditDialog(String postId, String currentContent) {
    final TextEditingController _editController =
    TextEditingController(text: currentContent);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text("Edit Post", style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _editController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Edit your post...",
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                _editPost(postId, _editController.text.trim());
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return Center(
        child: Text(
          "You need to log in to view your posts.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'My Posts',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
        .collection('posts')
        .where('userId', isEqualTo: currentUser.uid)
        .snapshots(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    }

    final myPosts = snapshot.data?.docs ?? [];
    if (myPosts.isEmpty) {
    return Center(
    child: Text(
    "No posts yet.",
    style: TextStyle(color: Colors.grey),
    ),
    );
    }

    return ListView.builder(
    itemCount: myPosts.length,
    itemBuilder: (context, index) {
    final post = myPosts[index].data() as Map<String, dynamic>;
    final postId = myPosts[index].id;

    return Card(
    color: Colors.grey[900],
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListTile(
    title: Text(
    post['content'] ?? '',
    style: TextStyle(color: Colors.white),
    ),subtitle: Text(
      "Posted by: ${post['userName'] ?? 'Anonymous'}",
      style: TextStyle(color: Colors.grey),
    ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.green),
            onPressed: () => _showEditDialog(postId, post['content']),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deletePost(postId),
          ),
        ],
      ),
    ),
    );
    },
    );
    },
        ),
    );
  }
}