import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gusto_master/logic/preference_cubit/preference_state.dart';
import 'package:gusto_master/presentation/pages/gusto_list_page.dart';
import 'package:gusto_master/logic/preference_cubit/preference_cubit.dart';
import 'package:gusto_master/data/models/gusto.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MockPreferenceCubit extends Mock implements PreferenceCubit {}

void main() {
  testWidgets('Eliminar gusto llama a deleteGusto en el cubit', (WidgetTester tester) async {
    final mockCubit = MockPreferenceCubit();
    final gusto = Gusto(
      id: '1',
      nombre: 'Test',
      imagenUrl: '',
      apiName: 'pikachu',
      tipos: ['eléctrico'],
    );
    when(() => mockCubit.state).thenReturn(
      PreferenceLoaded([gusto])
    );
    when(() => mockCubit.stream).thenAnswer(
      (_) => Stream.value(PreferenceLoaded([gusto]))
    );
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PreferenceCubit>.value(
          value: mockCubit,
          child: GustoListPage(),
        ),
      ),
    );
    await tester.tap(find.byIcon(Icons.delete));
    verify(() => mockCubit.deleteGusto('1')).called(1);
  });
}
