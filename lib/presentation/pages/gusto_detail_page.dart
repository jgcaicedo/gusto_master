import 'package:flutter/material.dart';
import 'package:gusto_master/core/utils/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../logic/preference_cubit/preference_cubit.dart';
import '../../data/models/gusto.dart';
import '../widgets/loadling_widget.dart';
import '../widgets/error_widget.dart';

/// Página de detalle que muestra la información completa de un gusto seleccionado.
class GustoDetailPage extends StatelessWidget {
  final String gustoId;

  const GustoDetailPage({super.key, required this.gustoId});

  @override
  Widget build(BuildContext context) {
    final gusto = context.read<PreferenceCubit>().getGustoById(gustoId);
    final responsive = Responsive(context);
    if (gusto == null) {
      return const CustomErrorWidget(message: 'Gusto no encontrado');
    }
    return Scaffold(
      appBar: AppBar(title: Text(gusto.nombre)),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.isMobile ? responsive.wp(4) : responsive.wp(20),
          vertical: responsive.hp(2),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  gusto.imagenUrl,
                  width: isWide ? 160 : 100,
                  height: isWide ? 160 : 100,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
                ),
                SizedBox(height: responsive.hp(2)),
                Text('Pokémon: ${gusto.apiName}', style: TextStyle(fontSize: isWide ? 22 : 18)),
                SizedBox(height: responsive.hp(1)),
                Text('Tipos: ${gusto.tipos.join(', ')}', style: TextStyle(fontSize: isWide ? 18 : 14)),
              ],
            );
          },
        ),
      ),
    );
  }
}
