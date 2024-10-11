import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controllers/player_bloc.dart';
import 'views/player_list_view.dart';
import 'themes/dark_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerBloc(),
      child: MaterialApp(
        title: 'Gamerstag',
        theme: darkTheme,
        home: PlayerListView(),
      ),
    );
  }
}
