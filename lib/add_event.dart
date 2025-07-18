import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  String _eventName = '';
  String _organizer = '';
  String _location = '';
  String _type = '';
  DateTime _eventDate = DateTime.now();
  DateTime _eventTime = DateTime.now();

  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _organizerController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _eventTypeController = TextEditingController();
  TextEditingController _eventDateController = TextEditingController();
  TextEditingController _eventTimeController = TextEditingController();

  // Function to add event to Firestore
  void _addEvent() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Create event data
        await _firestore.collection('events').add({
          'eventName': _eventName,
          'organizer': _organizer,
          'event type': _type,
          'location': _location,
          'date': _eventDate, // Store the event date
          'time': _eventTime, // Store the event time
        });

        // Clear the form after submitting
        _eventNameController.clear();
        _organizerController.clear();
        _locationController.clear();
        _eventTypeController.clear();
        _eventDateController.clear();
        _eventTimeController.clear();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Event Added Successfully!'),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error adding event: $e'),
        ));
      }
    }
  }

  // Date picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _eventDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null && selectedDate != _eventDate) {
      setState(() {
        _eventDate = selectedDate;
        _eventDateController.text = "${_eventDate.toLocal()}".split(' ')[0]; // Update the text controller to show date
      });
    }
  }

  // Time picker function
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _eventTime.hour, minute: _eventTime.minute),
    );
    if (selectedTime != null && selectedTime != TimeOfDay(hour: _eventTime.hour, minute: _eventTime.minute)) {
      setState(() {
        _eventTime = DateTime(_eventTime.year, _eventTime.month, _eventTime.day,
            selectedTime.hour, selectedTime.minute); // Update time while keeping the same date
        _eventTimeController.text = '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}'; // Update the text controller to show time
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Event Name
                TextFormField(
                  controller: _eventNameController,
                  decoration: InputDecoration(
                    labelText: 'Event Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _eventName = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Organizer
                TextFormField(
                  controller: _organizerController,
                  decoration: InputDecoration(
                    labelText: 'Organizer',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _organizer = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the organizer name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Location
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _location = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Event Type
                TextFormField(
                  controller: _eventTypeController,
                  decoration: InputDecoration(
                    labelText: 'Event Type',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _type = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Event Date Picker
                TextField(
                  controller: _eventDateController,
                  decoration: InputDecoration(
                    labelText: 'Event Date',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true, // Make the TextField read-only
                  onTap: () async {
                    await _selectDate(context); // Show date picker
                  },
                ),
                SizedBox(height: 16),

                // Event Time Picker
                TextField(
                  controller: _eventTimeController,
                  decoration: InputDecoration(
                    labelText: 'Event Time',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  readOnly: true, // Make the TextField read-only
                  onTap: () async {
                    await _selectTime(context); // Show time picker
                  },
                ),
                SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  onPressed: _addEvent,
                  child: Text('Add Event'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
