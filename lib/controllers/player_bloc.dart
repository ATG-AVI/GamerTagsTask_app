import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/player_model.dart';
import 'player_event.dart';
import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  List<Player> _players = [];

  PlayerBloc() : super(PlayerLoadInProgress()) {
    on<AddPlayer>((event, emit) {
      _players.add(event.player);
      emit(PlayerLoadSuccess(players: _players));
    });

    on<DeletePlayer>((event, emit) {
      _players.remove(event.player);
      emit(PlayerLoadSuccess(players: _players));
    });
  }
}
