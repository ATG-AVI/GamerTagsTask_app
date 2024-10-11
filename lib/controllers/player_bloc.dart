import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/player_model.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(PlayerInitial()) {
    on<AddPlayer>(_onAddPlayer);
  }

  void _onAddPlayer(AddPlayer event, Emitter<PlayerState> emit) {
    final updatedPlayers = List<PlayerModel>.from(state.players)
      ..add(event.player);
    emit(PlayerAdded(updatedPlayers));
  }
}
