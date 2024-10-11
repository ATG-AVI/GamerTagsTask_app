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
      appBar: AppBar(title: Text('Add Player')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Enter Player Name'),
                maxLength: 30,
              ),
              TextField(
                controller: gamersTagController,
                decoration: InputDecoration(labelText: 'Enter Gamers Tag ID'),
                maxLength: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          gamersTagController.text.isNotEmpty) {
                        final player = PlayerModel(
                          name: nameController.text,
                          gamersTag: gamersTagController.text,
                          avatarUrl: 'https://via.placeholder.com/150',
                        );
                        context.read<PlayerBloc>().add(AddPlayer(player));
                        Navigator.pop(context);
                      } else {
                        // Show an error message if fields are empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill in all fields')),
                        );
                      }
                    },
                    child: Text('Confirm'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
