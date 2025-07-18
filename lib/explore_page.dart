import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'event_page.dart';
import 'post_page.dart';
import 'success_story.dart';

class ExplorePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Explore",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _navigateToPage(context, 'events'),
                child: _buildSectionTitle("Upcoming Events"),
              ),
              _buildEventsList(),
              GestureDetector(
                onTap: () => _navigateToPage(context, 'posts'),
                child: _buildSectionTitle("Trending Posts"),
              ),
              _buildTrendingPostsList(),
              GestureDetector(
                onTap: () => _navigateToPage(context, 'stories'),
                child: _buildSectionTitle("Featured Alumni Stories"),
              ),
              _buildAlumniStoriesList(),
            ],
          ),
        ),
      );
  }

  void _navigateToPage(BuildContext context, String pageType) {
    switch (pageType) {
      case 'events':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventConnectPage()),
        );
        break;
      case 'posts':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostPage()),
        );
        break;
      case 'stories':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessStoriesApp()),
        );
        break;
    }
  }

  Widget _buildEventsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('events').limit(2).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return Column(
          children: snapshot.data!.docs.map((event) {
            return _buildEventCard(
              event['eventName'],
              event['event type'],
              event['location'],
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildTrendingPostsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('posts').limit(2).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return Column(
          children: snapshot.data!.docs.map((post) {
            return _buildTrendingPost(
              post['author'],
              post['content'],
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildAlumniStoriesList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('successStories').limit(2).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        return Column(
          children: snapshot.data!.docs.map((story) {
            final data = story.data() as Map<String, dynamic>;
            return _buildStoryCard(
              data['name'] ?? 'Unknown Name',
              data['story'] ?? 'No Story Available',
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEventCard(String title, String date, String location) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(Icons.event, color: Colors.green),
        title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text("$date • $location", style: TextStyle(color: Colors.grey)),
        trailing: Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }

  Widget _buildTrendingPost(String author, String content) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text(author, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(content, style: TextStyle(color: Colors.grey)),
      trailing: Icon(Icons.thumb_up, color: Colors.green),
    );
  }

  Widget _buildStoryCard(String name, String story) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(story, style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
