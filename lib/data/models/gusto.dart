import 'package:hive/hive.dart';
part 'gusto.g.dart';

@HiveType(typeId: 0)
/// Modelo que representa un gusto personalizado del usuario.
class Gusto {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final String imagenUrl;

  @HiveField(3)
  final String apiName;

  @HiveField(4)
  final List<String> tipos;

  Gusto({
    required this.id,
    required this.nombre,
    required this.imagenUrl,
    required this.apiName,
    required this.tipos,
  });

}