import 'package:flutter/material.dart';
import 'package:gusto_master/core/utils/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_master/logic/preference_cubit/preference_cubit.dart';
import 'package:gusto_master/logic/preference_cubit/preference_state.dart';
import 'package:go_router/go_router.dart';
import '../widgets/loadling_widget.dart';
import '../widgets/error_widget.dart';
import '../widgets/gusto_card.dart';

/// Página principal que muestra la lista de gustos guardados por el usuario.
/// Permite navegar a detalles, crear y eliminar gustos.
class GustoListPage extends StatelessWidget {
  const GustoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Gustos', style: textTheme.titleLarge),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.isMobile ? responsive.wp(4) : responsive.wp(15),
          vertical: responsive.hp(2),
        ),
        child: BlocBuilder<PreferenceCubit, PreferenceState>(
          builder: (context, state) {
            if (state is PreferenceLoading) {
              return const LoadingWidget();
            } else if (state is PreferenceError) {
              return CustomErrorWidget(
                message: state.message,
                onRetry: () => context.read<PreferenceCubit>().loadGustos(),
              );
            } else if (state is PreferenceLoaded) {
              if (state.gustos.isEmpty) {
                return CustomErrorWidget(
                  message: 'No hay gustos guardados.',
                  onRetry: () => context.read<PreferenceCubit>().loadGustos(),
                );
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  if (isWide) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.5,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: state.gustos.length,
                      itemBuilder: (context, index) {
                        final gusto = state.gustos[index];
                        return GustoCard(
                          gusto: gusto,
                          onDelete: () {
                            context.read<PreferenceCubit>().deleteGusto(gusto.id);
                          },
                          onTap: () => context.go('/prefs/${gusto.id}'),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.gustos.length,
                      itemBuilder: (context, index) {
                        final gusto = state.gustos[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: responsive.hp(1)),
                          child: GustoCard(
                            gusto: gusto,
                            onDelete: () {
                              context.read<PreferenceCubit>().deleteGusto(gusto.id);
                            },
                            onTap: () => context.go('/prefs/${gusto.id}'),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            }
            return const LoadingWidget();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/prefs/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
