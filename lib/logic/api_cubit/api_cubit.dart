import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/pokemon_dto.dart';
import '../../data/sources/pokemon_api.dart';
import 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  final PokemonApi api;

  ApiCubit(this.api) : super(ApiInitial());

  Future<void> fetchPokemons() async {
    emit(ApiLoading());
    try {
      final list = await api.getPokemonList();
      emit(ApiLoaded(list));
    } catch (e) {
      emit(ApiError('Error al cargar Pokémon'));
    }
  }
}
