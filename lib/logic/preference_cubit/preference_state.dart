import 'package:equatable/equatable.dart';
import '../../data/models/gusto.dart';

/// Estado base para la gestión de gustos en la aplicación.
/// Se utiliza en el patrón Cubit para manejar los diferentes estados.
abstract class PreferenceState extends Equatable {
  const PreferenceState();

  @override
  List<Object> get props => [];
}

/// Estado inicial antes de cargar o modificar gustos.
class PreferenceInitial extends PreferenceState {}

/// Estado que indica que se está realizando una operación de carga o modificación.
class PreferenceLoading extends PreferenceState {}

/// Estado que contiene la lista de gustos cargados correctamente.
class PreferenceLoaded extends PreferenceState {
  final List<Gusto> gustos;

  const PreferenceLoaded(this.gustos);

  @override
  List<Object> get props => [gustos];
}

/// Estado que indica que ocurrió un error en la gestión de gustos.
class PreferenceError extends PreferenceState {
  final String message;

  const PreferenceError(this.message);

  @override
  List<Object> get props => [message];
}
