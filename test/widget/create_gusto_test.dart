import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gusto_master/presentation/pages/gusto_form_page.dart';
import 'package:gusto_master/logic/preference_cubit/preference_cubit.dart';
import 'package:gusto_master/logic/preference_cubit/preference_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_master/data/models/pokemon_dto.dart';

class MockPreferenceCubit extends Mock implements PreferenceCubit {}

void main() {
  testWidgets('Crear gusto muestra error si no hay nombre ni Pokémon', (WidgetTester tester) async {
    final mockCubit = MockPreferenceCubit();
    when(() => mockCubit.state).thenReturn(PreferenceInitial());
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(PreferenceInitial()));
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PreferenceCubit>.value(
          value: mockCubit,
          child: GustoFormPage(),
        ),
      ),
    );
    await tester.tap(find.text('Guardar'));
    await tester.pump();
    expect(find.textContaining('Por favor'), findsOneWidget);
  });

  testWidgets('Crear gusto exitoso navega a la lista', (WidgetTester tester) async {
    final mockCubit = MockPreferenceCubit();
    when(() => mockCubit.state).thenReturn(PreferenceInitial());
    when(() => mockCubit.stream).thenAnswer((_) => Stream.value(PreferenceInitial()));

    // Usamos un GlobalKey para acceder al estado del widget y simular la selección de Pokémon
    final formKey = GlobalKey<GustoFormPageState>();
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PreferenceCubit>.value(
          value: mockCubit,
          child: Builder(
            builder: (context) {
              return Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => GustoFormPage(key: formKey),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), 'Mi gusto');

    // Creamos un Pokémon de prueba
    final testPokemon = PokemonDto(
      id: 1,
      name: 'bulbasaur',
      sprites: Sprites(frontDefault: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png'),
      types: [PokemonTypeSlot(type: TypeInfo(name: 'planta'))],
    );

    // Asignamos el Pokémon al estado del widget
    formKey.currentState!.selectedPokemon = testPokemon;
    await tester.pump();

    await tester.tap(find.text('Guardar'));
    await tester.pump();
    expect(find.textContaining('Por favor'), findsNothing);
  });
}
