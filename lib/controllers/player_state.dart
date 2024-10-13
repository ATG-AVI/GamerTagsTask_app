import 'package:gamerstagtask/models/player_model.dart';

abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerLoadInProgress extends PlayerState {}

class PlayerLoadSuccess extends PlayerState {
  final List<PlayerModel> players;

  PlayerLoadSuccess({required this.players});
}

class PlayerLoadFailure extends PlayerState {}

class PlayerAdded extends PlayerState {
  final PlayerModel player;

  PlayerAdded({required this.player});
}
