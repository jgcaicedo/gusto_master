import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_master/app.dart';
import 'package:gusto_master/data/repositories/gusto_repository.dart' as repo;
import 'package:gusto_master/data/sources/pokemon_api.dart';
import 'package:gusto_master/logic/api_cubit/api_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/models/gusto.dart';
import 'data/sources/local_storage.dart';
import 'logic/preference_cubit/preference_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(GustoAdapter());
  await Hive.openBox<Gusto>('gustos');

  runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => PreferenceCubit(HiveGustoRepository())..loadGustos(),
      ),
      BlocProvider(
        create: (_) => ApiCubit(PokemonApi())..fetchPokemons(),
      ),
    ],
    child: const GustoMasterApp(),
  ),
);

}
