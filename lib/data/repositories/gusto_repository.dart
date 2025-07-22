import 'package:hive/hive.dart';
import '../models/gusto.dart';

/// Interfaz para el repositorio de gustos.
/// Permite definir las operaciones básicas de persistencia.
abstract class GustoRepository {
  Future<void> add(Gusto gusto);
  Future<void> delete(String id);
  List<Gusto> getAll();
  Gusto? getById(String id);
}

/// Implementación de GustoRepository usando Hive como almacenamiento local.
class HiveGustoRepository implements GustoRepository {
  final Box<Gusto> box = Hive.box<Gusto>('gustos');

  @override
  Future<void> add(Gusto gusto) async {
    await box.put(gusto.id, gusto);
  }

  @override
  Future<void> delete(String id) async {
    await box.delete(id);
  }

  @override
  List<Gusto> getAll() {
    return box.values.toList();
  }

  @override
  Gusto? getById(String id) {
    return box.get(id);
  }
}
