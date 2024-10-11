part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  List<PlayerModel> get players => [];

  @override
  List<Object> get props => [];
}

class PlayerInitial extends PlayerState {
  @override
  List<Object> get props => [];
}

class PlayerAdded extends PlayerState {
  final List<PlayerModel> players;

  const PlayerAdded(this.players);

  @override
  List<Object> get props => [players];
}
