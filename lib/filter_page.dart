import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_play/sign_up.dart';


void main() => runApp(AlumniConnectPage());



class AlumniConnectPage extends StatefulWidget {
  @override
  _AlumniConnectPageState createState() => _AlumniConnectPageState();
}

class _AlumniConnectPageState extends State<AlumniConnectPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();

  String? selectedGraduationYear = "All";
  String? selectedIndustry = "All";
  String? selectedLocation = "All";
  String searchQuery = '';

  List<String> graduationYears = ["All"];
  List<String> industries = ["All"];
  List<String> locations = ["All"];

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
    final alumniDocs = await _firestore.collection('alumni').get();
    final data = alumniDocs.docs.map((doc) => doc.data()).toList();

    setState(() {
      graduationYears.addAll(data.map((e) => e['graduationYear'] as String).toSet().toList());
      industries.addAll(data.map((e) => e['major'] as String).toSet().toList());
      locations.addAll(data.map((e) => e['location'] as String).toSet().toList());
    });
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
            // Filters
            Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildDropdown('Graduation Year', graduationYears, selectedGraduationYear, (value) {
                      setState(() {
                        selectedGraduationYear = value;
                      });
                    }),
                    SizedBox(width: 20),
                    _buildDropdown('Branch', industries, selectedIndustry, (value) {
                      setState(() {
                        selectedIndustry = value;
                      });
                    }),
                    SizedBox(width: 20),
                    _buildDropdown('Location', locations, selectedLocation, (value) {
                      setState(() {
                        selectedLocation = value;
                      });
                    }),
                  ],
                ),
              ),
            ),

            // Alumni List
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('alumni').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final alumni = snapshot.data!.docs;
                  final filteredAlumni = alumni.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;

                    if (selectedGraduationYear != "All" &&
                        data['graduationYear'] != selectedGraduationYear) {
                      return false;
                    }

                    if (selectedIndustry != "All" &&
                        data['major'] != selectedIndustry) {
                      return false;
                    }

                    if (selectedLocation != "All" &&
                        data['location'] != selectedLocation) {
                      return false;
                    }

                    if (searchQuery.isNotEmpty &&
                        !data['name'].toString().toLowerCase().contains(searchQuery) &&
                        !data['major'].toString().toLowerCase().contains(searchQuery)) {
                      return false;
                    }

                    return true;
                  }).toList();

                  if (filteredAlumni.isEmpty) {
                    return Center(
                      child: Text(
                        'No alumni found with the selected filters.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredAlumni.length,
                    itemBuilder: (context, index) {
                      final data = filteredAlumni[index].data() as Map<String, dynamic>;

                      return _buildAlumniCard(
                        data['name'],
                        "Batch of ${data['graduationYear']}, ${data['major']}",
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
        backgroundColor:Colors.green,
        onPressed:() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>AlumniRegistration()),
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
          dropdownColor: Colors.grey[900],
          icon: Icon(Icons.arrow_downward, color: Colors.white),
          onChanged:onChanged,
        ),
      ],
    );
  }

  // Helper method to build alumni cards
  Widget _buildAlumniCard(String name, String description) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.person, size: 20, color: Colors.white),
            radius: 20,
          ),
          title: Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
