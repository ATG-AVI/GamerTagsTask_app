import 'package:gamerstagtask/models/player_model.dart';

abstract class PlayerEvent {}

class AddPlayer extends PlayerEvent {
  final PlayerModel player;

  AddPlayer(this.player);
}

class DeletePlayer extends PlayerEvent {
  final PlayerModel player;

  DeletePlayer(this.player);
}
