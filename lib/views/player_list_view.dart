import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controllers/player_bloc.dart';
import 'add_player_view.dart';

class PlayerListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Player List')),
      body: BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, state) {
          if (state is PlayerAdded) {
            return ListView.builder(
              itemCount: state.players.length,
              itemBuilder: (context, index) {
                final player = state.players[index];
                return ListTile(
                  leading: Image.network(player.avatarUrl),
                  title: Text(player.name),
                  subtitle: Text(player.gamersTag),
                );
              },
            );
          }
          return Center(child: Text('No players added yet.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPlayerView()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
