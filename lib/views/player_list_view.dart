import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            margin:
                const EdgeInsets.only(top: 16.0), // Add space above the AppBar
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
                // Add a thick white underline limited to the title
                Container(
                  height: 4.0, // Height of the white bar
                  color: Colors.white, // Color of the bar
                  width:
                      100, // Set width to match the text width or adjust as needed
                  margin: EdgeInsets.only(
                      top: 4.0), // Space between title and underline
                ),
                // Add a gradient red bar below the white underline with more space above
                Container(
                  height: 4.0, // Height of the gradient line
                  width: double.infinity, // Full width of the screen
                  margin: EdgeInsets.only(
                      top: 16.0), // Increased space between white and red line
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.red], // Gradient colors
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                // Box similar to "SHUFFLE THE MATCHES"
                Align(
                  alignment:
                      Alignment.centerLeft, // Align container to the left
                  child: Container(
                    width: 250, // Reduced width of the container
                    margin: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0), // Add space on the right
                    padding: EdgeInsets.all(8.0), // Reduced padding
                    decoration: BoxDecoration(
                      color: Colors.black, // Background color of the box
                      borderRadius: BorderRadius.zero, // No border radius
                      border: Border.all(
                          color: Colors.grey, width: 2.0), // Grey border
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check, color: Colors.white), // Tick icon
                            SizedBox(
                                width:
                                    4.0), // Reduced space between icon and text
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SHUFFLE THE MATCHES',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12, // Further reduced text size
                                  ),
                                ),
                                SizedBox(
                                    height: 2.0), // Reduced space between texts
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Last shuffled: ',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize:
                                              10, // Further reduced text size
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '4m ago', // This part will be green
                                        style: TextStyle(
                                          color: Colors
                                              .green, // Changed color to green
                                          fontSize: 10, // Same font size
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
                            backgroundColor: Colors.red, // Button color
                            foregroundColor: Colors.white, // Button text color
                            minimumSize: Size(40,
                                20), // Reduced size of the button (width, height)
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0), // Reduced padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero, // No border radius
                            ),
                          ),
                          child: Text(
                            'SHUFFLE',
                            style: TextStyle(
                                fontSize:
                                    10), // Further reduced button text size
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  // Use Expanded to make the body take up the remaining space
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<PlayerBloc, PlayerState>(
                      builder: (context, state) {
                        if (state is PlayerLoadInProgress) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is PlayerLoadSuccess) {
                          final players = state.players;
                          if (players.isEmpty) {
                            return Center(child: Text('No players added yet.'));
                          }
                          return ListView.builder(
                            itemCount: players.length,
                            itemBuilder: (context, index) {
                              final player = players[index];
                              return Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: player.avatarUrl.isNotEmpty
                                        ? NetworkImage(player.avatarUrl)
                                        : AssetImage(
                                            'assets/player.jpg'), // Ensure this asset is removed if not used
                                  ),
                                  title: Text(
                                    player.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors
                                          .white, // Ensure text color is visible
                                    ),
                                  ),
                                  subtitle: Text(
                                    player.gamersTag,
                                    style: TextStyle(
                                      color: Colors
                                          .white70, // Ensure text color is visible
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      context
                                          .read<PlayerBloc>()
                                          .add(DeletePlayer(player));
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state is PlayerLoadFailure) {
                          return Center(child: Text('Failed to load players.'));
                        }
                        return Center(child: Text('No players added yet.'));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16.0, // Position it to the right of the screen
            top: 150.0, // Adjusted vertical position to move the button
            child: SizedBox(
              width: 70, // Increased width of the button
              height: 70, // Increased height of the button
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/addPlayer'); // Navigate to Add Player
                },
                backgroundColor: Colors.red, // Set the background color to red
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .zero, // Set border radius to 0 (square shape)
                ),
                child: Icon(Icons.add,
                    size: 40,
                    color:
                        Colors.white), // Ensure icon color and size are visible
              ),
            ),
          ),
        ],
      ),
    );
  }
}
