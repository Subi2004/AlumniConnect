import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'add_event.dart';

//void main() => runApp(EventConnectPage());

class EventConnectPage extends StatefulWidget {
@override
_EventConnectPageState createState() => _EventConnectPageState();
}
class _EventConnectPageState extends State<EventConnectPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();

  String? selectedEventMonth="All";
  String? selectedEventType="All";
  String? selectedEventLocation="All";
  String searchQuery = '';

  List<String> eventMonths = ["All"];
  List<String> eventTypes = ["All"];
  List<String> eventLocations = ["All"];

  @override
  void initState() {
    super.initState();
    _fetchFilterOptions();
    _searchController.addListener(() {
      setState(() {
        searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  Future<void> _fetchFilterOptions() async {
    final eventDocs = await _firestore.collection('events').get();
    final data = eventDocs.docs.map((doc) => doc.data()).toList();

    setState(() {
      eventMonths = ["All"];
      eventMonths.addAll(data
          .map((e) => e['dateTime'] != null
          ? _formatToMonth(e['dateTime'] as Timestamp)
          : "No Date")
          .toSet()
          .toList());

      eventTypes = ["All"];
      eventTypes.addAll(data
          .map((e) => e['event type'] as String?)
          .where((e) => e != null && e.isNotEmpty)
          .cast<String>()
          .toSet()
          .toList());

      eventLocations = ["All"];
      eventLocations.addAll(data
          .map((e) => e['location'] as String?)
          .where((e) => e != null)
          .cast<String>()
          .toSet()
          .toList());
    });
  }

  String _formatToMonth(Timestamp? timestamp) {
    if (timestamp == null) {
      return "No Date";
    }
    final date = timestamp.toDate();
    return DateFormat('MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search alumni...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
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
            // Search bar
            Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDropdown('Date', eventMonths, selectedEventMonth, (value) {
                      setState(() {
                        selectedEventMonth = value;
                      });
                    }),
                    SizedBox(width: 20),
                    _buildDropdown('Type', eventTypes, selectedEventType, (value) {
                      setState(() {
                        selectedEventType = value;
                      });
                    }),
                    SizedBox(width: 20),
                    _buildDropdown('Location', eventLocations, selectedEventLocation,
                            (value) {
                          setState(() {
                            selectedEventLocation = value;
                          });
                        }),
                  ],
                ),
              ),
            ),

            // Event List
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('events').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final events = snapshot.data!.docs;
                  final filteredEvents = events.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;

                    final eventMonth = data['dateTime'] != null
                        ? _formatToMonth(data['dateTime'] as Timestamp)
                        : "No Date";

                    if (selectedEventMonth != "All" && eventMonth != selectedEventMonth) {
                      return false;
                    }

                    if (selectedEventType != "All" &&
                        data['event type'] != selectedEventType) {
                      return false;
                    }

                    if (selectedEventLocation != "All" &&
                        data['location'] != selectedEventLocation) {
                      return false;
                    }

                    if (searchQuery.isNotEmpty &&
                        !data['eventName']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery) &&
                        !data['event type']
                            .toString()
                            .toLowerCase()
                            .contains(searchQuery)) {
                      return false;
                    }

                    return true;
                  }).toList();

                  if (filteredEvents.isEmpty) {
                    return Center(
                      child: Text(
                        'No events found with the selected filters.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredEvents.length,
                    itemBuilder: (context, index) {
                      final data =
                      filteredEvents[index].data() as Map<String, dynamic>;

                      final eventDate = data['dateTime'] != null
                          ? _formatToMonth(data['dateTime'] as Timestamp)
                          : "Date Unavailable";

                      return _buildEventCard(
                        data['eventName'] ?? 'Unnamed Event',
                        "Type: ${data['event type'] ?? 'Unknown'}, Month: $eventDate",
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
          onPressed:() {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>AddEventPage()),
    );
    },
    child: Icon(Icons.add),
    ),
    );
  }

  // Helper method to build dropdowns
  Widget _buildDropdown(String label, List<String> items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey)),
        DropdownButton<String>(
          value: selectedValue,
          items: items
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e, style: TextStyle(color: Colors.white)),
          ))
              .toList(),
          dropdownColor: Colors.grey[800],
          icon: Icon(Icons.arrow_downward, color: Colors.white),
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Helper method to build event cards
  Widget _buildEventCard(String eventName, String description) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.event, size: 20, color: Colors.white),
            radius: 20,
          ),
          title: Text(eventName,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          subtitle: Text(description, style: TextStyle(color: Colors.white70)),
          trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {},
        child: Text("Connect"),
      ),
        ),
      ),
    );
  }
}
