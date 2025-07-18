import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Support",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section: FAQs
              _buildSectionTitle("Frequently Asked Questions"),
              _buildFaqItem("How do I register as an alumni?", "You can register through the Alumni Registration page."),
              _buildFaqItem("How can I donate?", "Navigate to the Donation Portal to make a contribution."),
              _buildFaqItem("How do I connect with other alumni?", "Visit the Networking Hub to explore alumni connections."),

              // Section: Contact Support
              _buildSectionTitle("Contact Support"),
              _buildContactOption(Icons.email, "Email Us", "alumni_support@example.com"),
              _buildContactOption(Icons.call, "Call Us", "+1 234 567 8900"),
              _buildContactOption(Icons.chat, "Chat with Us", "Start a live chat"),

              // Feedback Section
              _buildSectionTitle("Submit Feedback"),
              _buildFeedbackForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Card(
      color: Colors.grey[900],
      child: ExpansionTile(
        iconColor: Colors.green,
        collapsedIconColor: Colors.green,
        title: Text(question, style: TextStyle(color: Colors.white)),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(answer, style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(IconData icon, String title, String subtitle) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey)),
        onTap: () {
          // Handle contact action
        },
      ),
    );
  }

  Widget _buildFeedbackForm() {
    return Column(
      children: [
        TextField(
          style: TextStyle(color: Colors.white),
          maxLines: 4,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[800],
            hintText: "Write your feedback here...",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            // Submit feedback action
          },
          child: Text("Submit Feedback"),
        ),
      ],
    );
  }
}
