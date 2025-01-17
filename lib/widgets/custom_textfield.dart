import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLength;
  final IconData? icon; // Optional icon field

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.maxLength,
    this.icon, // Allow optional icon to be passed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0), // Add padding for better layout
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w100,
              color: Colors.white, // Ensure label text color is visible
            ),
            border:
                OutlineInputBorder(), // Use OutlineInputBorder for better visibility
            filled: true,
            fillColor: Colors.grey[800], // Set fill color for better visibility
            counterText: '',
            prefixIcon: icon != null
                ? Icon(icon,
                    color: Colors.white) // Display the icon if provided
                : null, // No icon if not provided
          ),
          maxLength: maxLength,
          style: TextStyle(color: Colors.white), // Ensure text color is visible
        ),
      ),
    );
  }
}
