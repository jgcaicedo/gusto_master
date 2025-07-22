import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gusto_master/data/models/gusto.dart';
import 'package:gusto_master/data/sources/local_storage.dart';
import 'package:gusto_master/logic/preference_cubit/preference_cubit.dart';
import 'package:gusto_master/logic/preference_cubit/preference_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGustoRepository extends Mock implements GustoRepository {}

void main() {
  late PreferenceCubit cubit;
  late MockGustoRepository mockRepo;

  final testGusto = Gusto(
    id: 'test-id',
    nombre: 'Mi gusto',
    imagenUrl: 'https://url.png',
    apiName: 'pikachu',
    tipos: ['electric'],
  );

  setUp(() {
    mockRepo = MockGustoRepository();
    cubit = PreferenceCubit(mockRepo);
  });

  group('PreferenceCubit', () {
    test('initial state is PreferenceInitial', () {
      expect(cubit.state, PreferenceInitial());
    });

    blocTest<PreferenceCubit, PreferenceState>(
      'emits [Loading, Loaded] when loadGustos succeeds',
      build: () {
        when(() => mockRepo.getAll()).thenReturn([testGusto]);
        return cubit;
      },
      act: (cubit) => cubit.loadGustos(),
      expect: () => [
        PreferenceLoading(),
        PreferenceLoaded([testGusto]),
      ],
    );

    blocTest<PreferenceCubit, PreferenceState>(
      'emits [Loading, Loaded] after addGusto',
      build: () {
        when(() => mockRepo.add(testGusto)).thenAnswer((_) async {});
        when(() => mockRepo.getAll()).thenReturn([testGusto]);
        return cubit;
      },
      act: (cubit) => cubit.addGusto(testGusto),
      expect: () => [
        PreferenceLoading(),
        PreferenceLoaded([testGusto]),
      ],
    );

    blocTest<PreferenceCubit, PreferenceState>(
      'emits [Loading, Loaded] after deleteGusto',
      build: () {
        when(() => mockRepo.delete('test-id')).thenAnswer((_) async {});
        when(() => mockRepo.getAll()).thenReturn([]);
        return cubit;
      },
      act: (cubit) => cubit.deleteGusto('test-id'),
      expect: () => [
        PreferenceLoading(),
        PreferenceLoaded([]),
      ],
    );

    test('getGustoById returns correct gusto', () {
      when(() => mockRepo.getById('test-id')).thenReturn(testGusto);
      final result = cubit.getGustoById('test-id');
      expect(result, testGusto);
    });
  });
}
