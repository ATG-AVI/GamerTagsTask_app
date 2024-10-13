import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controllers/player_bloc.dart';
import 'views/add_player_view.dart';
import 'themes/dark_theme.dart'; // Adjust the path if necessary

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerBloc(),
      child: MaterialApp(
        title: 'Player Management',
        theme: ThemeData.light(), // Keep the light theme if needed
        darkTheme: darkTheme, // Set the dark theme
        themeMode: ThemeMode.dark, // Use dark theme by default
        home: AddPlayerView(),
      ),
    );
  }
}
