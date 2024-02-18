import 'package:flutter/material.dart';

class FooterIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey[900], // Use a dark color for the background
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: Colors.white), // Use white color for the icon
            onPressed: () {
              // Navigate to home page
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white), // Use white color for the icon
            onPressed: () {
              // Navigate to search page
            },
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner, color: Colors.white), // Use white color for the icon
            onPressed: () {
              // Navigate to scan page
            },
          ),
          IconButton(
            icon: Icon(Icons.stacked_bar_chart, color: Colors.white), // Use white color for the icon
            onPressed: () {
              // Navigate to cart page
            },
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white), // Use white color for the icon
            onPressed: () {
              // Navigate to profile page
            },
          ),
        ],
      ),
    );
  }
}
