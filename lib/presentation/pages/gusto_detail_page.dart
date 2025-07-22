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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).go('/prefs'),
        ),
        title: Text(gusto.nombre, style: textTheme.titleLarge),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsive.isMobile ? responsive.wp(4) : responsive.wp(20),
            vertical: responsive.hp(4),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              return Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                color: colorScheme.surface,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 48 : 24,
                    vertical: isWide ? 32 : 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withOpacity(0.12),
                              blurRadius: 16,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            gusto.imagenUrl,
                            width: isWide ? 160 : 100,
                            height: isWide ? 160 : 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 100, color: colorScheme.error),
                          ),
                        ),
                      ),
                      SizedBox(height: responsive.hp(3)),
                      Text(
                        gusto.nombre,
                        style: textTheme.headlineMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: responsive.hp(2)),
                      Text(
                        'Pokémon: ${gusto.apiName}',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: responsive.hp(1)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Tipos: ${gusto.tipos.join(', ')}',
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
