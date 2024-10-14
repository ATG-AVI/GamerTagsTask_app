import '../models/player_model.dart';

abstract class PlayerEvent {}

class AddPlayer extends PlayerEvent {
  final Player player;

  AddPlayer(this.player);
}

class DeletePlayer extends PlayerEvent {
  final Player player;

  DeletePlayer(this.player);
}
