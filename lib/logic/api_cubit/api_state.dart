import 'package:equatable/equatable.dart';
import '../../data/models/pokemon_dto.dart';

/// Estado base para la gestión de la API de Pokémon.
abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial antes de cargar datos de la API.
class ApiInitial extends ApiState {}

/// Estado que indica que se está realizando una operación de carga desde la API.
class ApiLoading extends ApiState {}

/// Estado que contiene la lista de Pokémon cargados correctamente desde la API.
class ApiLoaded extends ApiState {
  final List<PokemonDto> items;

  const ApiLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

/// Estado que indica que ocurrió un error al obtener datos de la API.
class ApiError extends ApiState {
  final String message;

  const ApiError(this.message);

  @override
  List<Object?> get props => [message];
}
