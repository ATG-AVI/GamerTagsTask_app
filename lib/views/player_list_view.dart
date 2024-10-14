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
      body: Container(
        margin: const EdgeInsets.only(top: 16.0), // Add space above the AppBar
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black, // Background color of the box
                borderRadius: BorderRadius.zero, // No border radius
                border: Border.all(color: Colors.red, width: 2.0), // Red border
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align items to the start
                children: [
                  Icon(
                    Icons.check, // Tick icon
                    color: Colors.white, // Icon color
                  ),
                  SizedBox(width: 8.0), // Space between the icon and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SHUFFLE THE MATCHES',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14, // Reduced font size
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Last shuffled: 4m ago', // Example timestamp
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Spacer(), // Take available space
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Button color
                      foregroundColor: Colors.white, // Button text color
                    ),
                    child: Text('SHUFFLE'),
                  ),
                ],
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
                                icon:
                                    Icon(Icons.delete, color: Colors.redAccent),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addPlayer'); // Navigate to Add Player
        },
        child: Icon(Icons.add), // Ensure icon color is visible
      ),
    );
  }
}
