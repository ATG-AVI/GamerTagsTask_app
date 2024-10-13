import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/player_bloc.dart';
import '../controllers/player_event.dart';
import '../controllers/player_state.dart';
import '../models/player_model.dart';
import 'add_player_view.dart';

class PlayerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player List'),
      ),
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          if (state is PlayerLoadInProgress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PlayerLoadSuccess) {
            final players = state.players; // Ensure this is a List<PlayerModel>
            if (players.isEmpty) {
              return Center(child: Text('No players added yet.'));
            }
            return ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                final player = players[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(player.avatarUrl),
                  ),
                  title: Text(player.name),
                  subtitle: Text(player.gamersTag),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Trigger the DeletePlayer event
                      context.read<PlayerBloc>().add(DeletePlayer(player));
                    },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to AddPlayerView and await the result
          final newPlayer = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPlayerView(),
            ),
          );

          // Add the new player to the BLoC state if not null
          if (newPlayer != null) {
            context.read<PlayerBloc>().add(AddPlayer(newPlayer));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
