import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import '../controllers/player_bloc.dart';
import '../controllers/player_event.dart';
import '../controllers/player_state.dart';
import '../models/player_model.dart';

class PlayerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16.0), // Space above the AppBar
            child: Column(
              children: [
                AppBar(
                  title: Center(
                    child: Text(
                      'BRACKET',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                // White underline for the title
                Container(
                  height: 4.0,
                  color: Colors.white,
                  width: 100,
                  margin: EdgeInsets.only(top: 2.0),
                ),
                // Gradient red bar
                Container(
                  height: 4.0,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.red],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                // "SHUFFLE THE MATCHES" section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 250,
                    margin:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.zero,
                      border:
                          Border.all(color: Colors.grey), // Added grey border
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check, color: Colors.white),
                            SizedBox(width: 4.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SHUFFLE THE MATCHES',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 2.0),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Last shuffled: ',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '4m ago',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            minimumSize: Size(40, 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            'SHUFFLE',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // PageView for Quarter Finals, Semi Finals, and Finals
                Expanded(
                  child: PageView(
                    children: [
                      buildStagePage('Quarter Finals', 'Match 1'),
                      buildStagePage('Semi Finals', 'Match 3'),
                      buildStagePage('Finals', ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16.0,
            top: 143.0, // Adjusted top value to shift the button above
            child: SizedBox(
              width: 70,
              height: 70,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addPlayer');
                },
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                child: Icon(Icons.add, size: 40, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each stage page with a title and optional subtitle
  Widget buildStagePage(String title, String subtitle) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            SizedBox(height: 16.0), // Space between text and boxes
            if (title == 'Quarter Finals') ...[
              buildBoxWithNumber(),
              SizedBox(height: 16.0), // Space between the two boxes
              buildBoxWithNumber(),
              SizedBox(height: 16.0), // Space between the two sections
              Text(
                'Match 2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16.0), // Space between text and boxes
              buildBoxWithNumber(),
              SizedBox(height: 16.0), // Space between the two boxes
              buildBoxWithNumber(),
            ] else if (title == 'Semi Finals') ...[
              Text(
                'Match 3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16.0), // Space between text and boxes
              buildBoxWithNumber(),
              SizedBox(height: 16.0), // Space between the two boxes
              buildBoxWithNumber(),
            ] else if (title == 'Finals') ...[
              buildBoxWithNumber(),
            ],
          ],
        ),
      ),
    );
  }

  // Helper method to build a box with a CircleAvatar on the left side and a random number on the right side
  Widget buildBoxWithNumber() {
    final randomNumber =
        Random().nextInt(100); // Generate a random number between 0 and 99
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.only(right: 32.0), // Decrease size from the right
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor:
                    Colors.grey, // Set a background color instead of an image
              ),
              SizedBox(
                  width: 8.0), // Space between the avatar and the number box
            ],
          ),
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(
                right: 8.0), // Margin to separate from the border
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                randomNumber.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
