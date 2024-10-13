import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/player_model.dart';
import 'player_event.dart';
import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  List<PlayerModel> _players = []; // Maintain a list of players

  PlayerBloc() : super(PlayerInitial()) {
    // Register event handlers
    on<AddPlayer>((event, emit) {
      _players.add(event.player); // Add player to the list
      emit(PlayerLoadSuccess(
          players: _players)); // Emit success state with updated players list
    });

    on<DeletePlayer>((event, emit) {
      _players.remove(event.player); // Remove player from the list
      emit(PlayerLoadSuccess(
          players: _players)); // Emit success state with updated players list
    });
  }
}
