part of 'player_bloc.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class AddPlayer extends PlayerEvent {
  final PlayerModel player;

  const AddPlayer(this.player);

  @override
  List<Object> get props => [player];
}
