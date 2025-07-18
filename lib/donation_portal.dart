import 'package:flutter/material.dart';

class DonationPortal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context); // Navigate back to the previous screen
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Navigate back manually
            },
          ),
          title: Text(
            "AlumniConnect - Donation Portal",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Donation Amount Section
              Text("Make a Donation",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Donation Amount:",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Text("Enter Amount", style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAmountButton("\$10"),
                  _buildAmountButton("\$25"),
                  _buildAmountButton("\$50"),
                ],
              ),
              SizedBox(height: 20),

              // Payment Method Section
              Text("Payment Method",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.credit_card, color: Colors.white),
                  SizedBox(width: 20),
                  Icon(Icons.payment, color: Colors.white),
                ],
              ),
              SizedBox(height: 20),

              // Donation Tracker Section
              Text("Donation Tracker",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.7,
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
              SizedBox(height: 20),

              // Recurring Donation Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Set up recurring donation:",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.green,
                  )
                ],
              ),
              SizedBox(height: 20),

              // Donation History Section
              Text("Donation History",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Nov 2023       \$50",
                  style: TextStyle(color: Colors.white)),
              Text("Oct 2023       \$25",
                  style: TextStyle(color: Colors.white)),
              Text("Sep 2023       \$100",
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountButton(String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        onPressed: () {},
        child: Text(amount),
      ),
    );
  }
}
