import 'package:flutter/material.dart';
import 'package:gusto_master/core/utils/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/gusto.dart';
import '../../data/models/pokemon_dto.dart';
import '../../logic/preference_cubit/preference_cubit.dart';
import '../widgets/loadling_widget.dart';
import '../widgets/error_widget.dart';

/// Página para crear un nuevo gusto.
/// Permite seleccionar un Pokémon y asignarle un nombre personalizado.
class GustoFormPage extends StatefulWidget {
  const GustoFormPage({super.key});

  @override
  State<GustoFormPage> createState() => GustoFormPageState();
}

/// Estado de la página de formulario para crear gustos.
class GustoFormPageState extends State<GustoFormPage> {
  final TextEditingController _nameController = TextEditingController();
  PokemonDto? selectedPokemon;
  bool _isLoading = false;
  String? _errorMessage;

  void _selectPokemon() async {
    final result = await context.push<PokemonDto>('/api-list');
    if (result != null) {
      setState(() {
        selectedPokemon = result;
      });
    }
  }

  void _saveGusto() async {
    if (selectedPokemon == null || _nameController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, selecciona un pokemon y escribe un nombre.';
      });
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    final gusto = Gusto(
      id: const Uuid().v4(),
      nombre: _nameController.text.trim(),
      imagenUrl: selectedPokemon!.sprites.frontDefault,
      apiName: selectedPokemon!.name,
      tipos: selectedPokemon!.types.map((t) => t.type.name).toList(),
    );
    context.read<PreferenceCubit>().addGusto(gusto);
    setState(() {
      _isLoading = false;
    });
    // Solo navega si hay GoRouter en el contexto
    try {
      GoRouter.of(context).go('/prefs');
    } catch (_) {
      // Ignora si no hay GoRouter (por ejemplo, en tests)
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Gusto')),
      body: _isLoading
          ? const LoadingWidget()
          : Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.isMobile ? responsive.wp(4) : responsive.wp(20),
                vertical: responsive.hp(2),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Nombre del gusto'),
                      ),
                      SizedBox(height: responsive.hp(2)),
                      isWide
                          ? Row(
                              children: [
                                ElevatedButton(
                                  onPressed: _selectPokemon,
                                  child: const Text('Seleccionar Pokémon'),
                                ),
                                SizedBox(width: responsive.wp(2)),
                                if (selectedPokemon != null)
                                  Image.network(
                                    selectedPokemon!.sprites.frontDefault,
                                    width: 64,
                                    height: 64,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 64),
                                  ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: _selectPokemon,
                                  child: const Text('Seleccionar Pokémon'),
                                ),
                                SizedBox(height: responsive.hp(1)),
                                if (selectedPokemon != null)
                                  Image.network(
                                    selectedPokemon!.sprites.frontDefault,
                                    width: 48,
                                    height: 48,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 48),
                                  ),
                              ],
                            ),
                      SizedBox(height: responsive.hp(2)),
                      SizedBox(
                        width: isWide ? responsive.wp(30) : double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveGusto,
                          child: const Text('Guardar'),
                        ),
                      ),
                      if (_errorMessage != null) ...[
                        SizedBox(height: responsive.hp(2)),
                        CustomErrorWidget(message: _errorMessage!),
                      ],
                    ],
                  );
                },
              ),
            ),
    );
  }}