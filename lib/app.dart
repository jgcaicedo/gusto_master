import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gusto_master/core/constants/app_theme.dart';
import 'package:gusto_master/presentation/pages/api_list_page.dart';
import 'package:gusto_master/presentation/pages/gusto_detail_page.dart';
import 'package:gusto_master/presentation/pages/gusto_form_page.dart';
import 'package:gusto_master/presentation/pages/gusto_list_page.dart';

/// Clase principal de la aplicación Gusto Master.
/// Configura el tema, las rutas y el punto de entrada de la app.
class GustoMasterApp extends StatelessWidget {
  const GustoMasterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gusto Master',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

//Rutas de la aplicación
final GoRouter _router = GoRouter(
  initialLocation: '/prefs',
  routes: [
    GoRoute(
      path: '/prefs',
      builder: (context, state) => const GustoListPage(),
    ),
    GoRoute(
      path:'/prefs/new',
      builder: (context, state) => const GustoFormPage(),
    ),
    GoRoute(
      path: '/prefs/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ;
        return GustoDetailPage(gustoId: id!);
      },
    ),
    GoRoute(
      path: '/api-list',
      builder: (context, state) => const ApiListPage(),
    )
  ]

);