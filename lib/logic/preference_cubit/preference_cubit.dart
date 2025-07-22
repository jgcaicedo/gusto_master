import 'package:flutter_bloc/flutter_bloc.dart';
import 'preference_state.dart';
import '../../data/models/gusto.dart';
import '../../data/sources/local_storage.dart';

/// Cubit encargado de manejar la lógica de negocio para los gustos del usuario.
/// Permite agregar, eliminar y obtener gustos usando Hive como almacenamiento local.
class PreferenceCubit extends Cubit<PreferenceState> {
  final GustoRepository repository;

  PreferenceCubit(this.repository) : super(PreferenceInitial());

  void loadGustos() async {
    emit(PreferenceLoading());
    try {
      final gustos = repository.getAll();
      emit(PreferenceLoaded(gustos));
    } catch (e) {
      emit(PreferenceError('Error al cargar gustos'));
    }
  }

  void addGusto(Gusto gusto) async {
    await repository.add(gusto);
    loadGustos(); // refrescar lista
  }

  void deleteGusto(String id) async {
    await repository.delete(id);
    loadGustos(); // refrescar lista
  }

  Gusto? getGustoById(String id) {
    return repository.getById(id);
  }
}
