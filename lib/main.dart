import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamerstagtask/themes/dark_theme.dart';
import 'controllers/player_bloc.dart';
import 'views/player_list_view.dart';
import 'views/add_player_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: darkTheme, // Apply the dark theme
        home: PlayerListView(),
        routes: {
          '/addPlayer': (context) => AddPlayerView(),
        },
      ),
    );
  }
}
