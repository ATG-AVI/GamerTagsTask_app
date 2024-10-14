import '../models/player_model.dart';

abstract class PlayerState {}

class PlayerInitial extends PlayerState {}

class PlayerLoadInProgress extends PlayerState {}

class PlayerLoadSuccess extends PlayerState {
  final List<Player> players;

  PlayerLoadSuccess({required this.players});
}

class PlayerLoadFailure extends PlayerState {}
