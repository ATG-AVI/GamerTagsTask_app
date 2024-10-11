import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/player_bloc.dart';
import '../models/player_model.dart';

class AddPlayerView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gamersTagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 400, // Set a fixed width to make it more rectangular
            constraints: BoxConstraints(
              maxHeight:
                  600, // Set a maximum height to maintain the rectangular shape
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Add Player',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Enter new player name',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.withOpacity(0.5),
                                  Colors.grey.withOpacity(0.5)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: Colors.black, width: 2.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white
                                      .withOpacity(0.3), // Reduced opacity
                                  spreadRadius: -5, // Reduced spread radius
                                  blurRadius: 15, // Reduced blur radius
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            height: 60, // Adjust height as needed
                          ),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Enter Player Name',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight
                                      .w100), // Make the text very thin
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors
                                  .transparent, // Make the TextField background transparent
                              counterText: '', // Remove the character counter
                            ),
                            maxLength: 30,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.red.withOpacity(0.5),
                                  Colors.redAccent.withOpacity(0.5)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                              border:
                                  Border.all(color: Colors.black, width: 2.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white
                                      .withOpacity(0.3), // Reduced opacity
                                  spreadRadius: -5, // Reduced spread radius
                                  blurRadius: 15, // Reduced blur radius
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            height: 60, // Adjust height as needed
                          ),
                          TextField(
                            controller: gamersTagController,
                            decoration: InputDecoration(
                              labelText: 'Enter Gamers Tag ID',
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight
                                      .w100), // Make the text very thin
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors
                                  .transparent, // Make the TextField background transparent
                              counterText: '', // Remove the character counter
                            ),
                            maxLength: 10,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (nameController.text.isNotEmpty &&
                                  gamersTagController.text.isNotEmpty) {
                                final player = PlayerModel(
                                  name: nameController.text,
                                  gamersTag: gamersTagController.text,
                                  avatarUrl: 'https://via.placeholder.com/150',
                                );
                                context
                                    .read<PlayerBloc>()
                                    .add(AddPlayer(player));
                                Navigator.pop(context);
                              } else {
                                // Show an error message if fields are empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Please fill in all fields')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.red, // Set the background color to red
                            ),
                            child: Text('Confirm'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
