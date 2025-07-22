import 'package:flutter/material.dart';
import 'package:gusto_master/core/utils/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_master/logic/api_cubit/api_cubit.dart';
import 'package:gusto_master/logic/api_cubit/api_state.dart';
import '../widgets/loadling_widget.dart';
import '../widgets/error_widget.dart';

/// Página que muestra la lista de Pokémon obtenidos desde la API.
/// Permite seleccionar un Pokémon para asociarlo a un gusto.
class ApiListPage extends StatelessWidget {
  const ApiListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Selecciona un Pokémon')),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: responsive.isMobile ? responsive.wp(4) : responsive.wp(15),
          vertical: responsive.hp(2),
        ),
        child: BlocBuilder<ApiCubit, ApiState>(
          builder: (context, state) {
            if (state is ApiLoading) {
              return const LoadingWidget();
            } else if (state is ApiLoaded) {
              if (state.items.isEmpty) {
                return const CustomErrorWidget(message: 'No hay Pokémon disponibles.');
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  if (isWide) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemCount: state.items.length,
                      itemBuilder: (_, i) {
                        final item = state.items[i];
                        return ListTile(
                          leading: Image.network(
                            item.sprites.frontDefault,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                          ),
                          title: Text(item.name),
                          onTap: () {
                            Navigator.pop(context, item);
                          },
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.items.length,
                      itemBuilder: (_, i) {
                        final item = state.items[i];
                        return Padding(
                          padding: EdgeInsets.only(bottom: responsive.hp(1)),
                          child: ListTile(
                            leading: Image.network(
                              item.sprites.frontDefault,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
                            ),
                            title: Text(item.name),
                            onTap: () {
                              Navigator.pop(context, item);
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              );
            } else if (state is ApiError) {
              return CustomErrorWidget(message: state.message);
            }
            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
